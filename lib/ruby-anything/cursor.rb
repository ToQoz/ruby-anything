# -*- coding: utf-8 -*-

module RubyAnything
  class Cursor
    attr_accessor :x, :y

    def initialize(opt = {})
      @x = opt[:x] || 0
      @y = opt[:y] || 0
      @minx = opt[:minx] || 0
      @miny = opt[:miny] || 0
    end

    def clear
      self.x = 0
      self.y = 0
    end

    def up
      self.y -= 1 if @miny < y
    end

    def down
      self.y += 1
    end

    def left
      self.x -= 1 if @minx < x
    end

    def right
      self.x += 1
    end
  end
end
