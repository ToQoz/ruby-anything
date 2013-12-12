# -*- coding: utf-8 -*-

module RubyAnything
  # prefix `c_` is curses
  class BaseWindow
    attr_accessor :top
    attr_reader :cursor

    # Public: Hash has name as key and has array of keycode as value
    KEYS = {
      up: [ Curses::Key::UP, 16 ],
      down: [ Curses::Key::DOWN, 14 ],
      left: [ Curses::Key::LEFT, 2 ],
      right: [ Curses::Key::RIGHT, 6 ],
      enter: [ 10 ],
      backspace: [ 127 ],
      interrupt: [ 3, 4 ]
    }
    # Public: initialize BaseWindow
    #
    # parent - The Curses::Window or RubyAnything::Window is parent window for self
    # opt    - The Hash is options for drawing self
    #          :h height
    #          :w width
    #          :y y-axis
    #          :x x-axis
    def initialize(parent, opt)
      @parent = parent
      @c_window = @parent.subwin(
        opt[:h] || @parent.maxy,
        opt[:w] || @parent.maxx,
        opt[:y] || 0,
        opt[:x] || 0
      )
      @cursor = Cursor.new
      @top = 0
      update
    end

    def collection; [] end
    def view_collection; collection[@top..@top + maxy - 1] || [] end

    def update
      in_pos(0, 0) {
        view_collection.each_with_index do |item, index|
          draw_at index
        end
      }
    end

    def on_input(ch) end

    def draw_at(y)
      setpos(y, 0)
      clrtoeol
      if (line = view_collection[y])
        addstr line[0..(maxx - 1)]
      end
    end

    def draw_at!(y)
      draw_at y
      refresh
    end

    def before_left
      @cursor.x > 0
    end

    def before_right
      @cursor.x < view_collection[@cursor.y].size
    end

    def before_down
      cursor.y + 1 < view_collection.size
    end

    def before_up
      cursor.y > 0
    end

    def down
      unless before_down
        @top += 1 if collection.size > @top + maxy
        update
      else
        change_focus_line { cursor.down }
        refresh
      end
    end

    def up
      return unless before_up
      change_focus_line { cursor.up }
      refresh
    end

    def left
      return unless before_left
      cursor.left
      refresh
    end

    def right
      return unless before_right
      cursor.right
      refresh
    end

    def change_focus_line
      normalize_line
      yield if block_given?
      enhansive_line
    end

    def normalize_line
      in_pos(cursor.y, 0) { draw_at(cursor.y) }
      refresh
    end

    def enhansive_line
      in_color(RubyAnything::ENHANSIVE_COLOR) {
        in_pos(cursor.y, 0) { draw_at(cursor.y) }
        refresh
      }
    end

    def in_pos(y, x)
      setpos(y, x)
      yield self if block_given?
      setpos(y, x)
    end

    def in_color(color)
      attron(Curses.color_pair(color))
      yield self if block_given?
      attroff(Curses::A_COLOR)
    end

    def refresh
      setpos cursor.y, cursor.x
      @c_window.refresh
    end

    # delegate to instance of Curses::Window
    def method_missing(name, *args)
      if @c_window.respond_to? name.to_s
        @c_window.send name.to_s, *args
      else
        super
      end
    end
  end
end
