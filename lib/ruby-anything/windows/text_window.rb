# -*- coding: utf-8 -*-

module RubyAnything
  class TextWindow < BaseWindow
    attr_accessor :items_window

    def initialize(parent, opt = {})
      super(parent, opt)
    end

    def text
      @text ||= Text.new
    end

    def update; draw_at! 0 end
    def view_collection; [ text.to_s ] end

    def on_input(ch)
      # require 'logger'
      # @logger ||= Logger.new('/tmp/ch.txt')
      # @logger.info ch
      case ch
      when *KEYS[:left]
        left
      when *KEYS[:right]
        right
      when Curses::Key::BACKSPACE
        delete
      when String
        insert ch
      end
    end

    def delete
      cursor.left
      text.delete cursor.x
      @parent.filter text.to_s
      update
    end

    def insert(ch)
      text.insert cursor.x, ch
      cursor.right
      @parent.filter text.to_s
      update
    end
  end
end
