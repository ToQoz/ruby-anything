# -*- coding: utf-8 -*-

module RubyAnything
  require "ruby-anything/filterable"
  require "ruby-anything/text"
  require "ruby-anything/cursor"
  require 'ruby-anything/base_window'
  require 'ruby-anything/windows/prompt_window'
  require 'ruby-anything/windows/text_window'
  require 'ruby-anything/windows/items_window'

  ENHANSIVE_COLOR = 1
  PROMPT_COLOR = 2

  class Windows < BaseWindow
    attr_accessor :items_window, :text_window

    class << self
      def anything(items)
        windows = new items.extend(Filterable)
        begin
          loop {
            break unless windows.active?
            windows.on_input Curses.getch
          }
          windows.selected_item
        ensure
          windows.close unless Curses.closed?
        end
      end
    end

    def initialize(items)
      super(screen, h: screen.maxy, w: screen.maxx, y: 0, x: 0)

      @active = true
      @text_window = TextWindow.new self, opt(:text)
      @items_window = ItemsWindow.new self, items, opt(:items)
      PromptWindow.new self, prompt, opt(:prompt)

      @screen.setpos @text_window.begy, @text_window.begx
      @screen.refresh
    end

    def active?; @active end
    def deactivate; @active = false end
    def prompt; '> ' end

    def opt(window_type)
      case window_type
      when :prompt
        { h: 1, w: prompt.size, y: 0, x: 0}
      when :text
        { h: 1, w: maxx - prompt.size, y: 0, x: 2 }
      when :items
        { h: maxy - 1, w: maxx, y: 1, x: 0 }
      else
        {}
      end
    end

    def on_input(ch)
      case ch
      when *KEYS[:enter], *KEYS[:interrupt]
        deactivate
      when *KEYS[:up], *KEYS[:down]
        items_window.on_input ch
      else
        text_window.on_input ch
      end
    end

    def screen
      unless @screen
        configure_curses
        @screen = Curses.stdscr
      end
      @screen
    end

    def close
      items_window.close
      text_window.close
      @c_window.close
      Curses.close_screen
    end

    def configure_curses
      Curses.class_eval do
        init_screen
        raw
        noecho
        start_color
        init_pair ENHANSIVE_COLOR, Curses::COLOR_WHITE, Curses::COLOR_MAGENTA
        init_pair PROMPT_COLOR, Curses::COLOR_YELLOW, 0
        stdscr.keypad(true)
      end
    end

    # delegate to items_window
    def selected_item; items_window.selected_item end
    def filter(*args) items_window.filter(*args) end
  end
end
