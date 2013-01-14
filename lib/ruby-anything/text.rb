# -*- coding: utf-8 -*-

module RubyAnything
  class Text
    def initialize
      @io = []
    end

    def to_a
      @io
    end

    def to_s
      @io.join('')
    end

    def insert(index, ch)
      @io.insert index, ch
    end

    def delete(index)
      @io.delete_at index
    end
  end
end
