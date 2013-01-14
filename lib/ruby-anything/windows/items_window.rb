# -*- coding: utf-8 -*-

module RubyAnything
  class ItemsWindow < BaseWindow
    attr_accessor :items

    def initialize(parent, items = [], opt)
      @items = items
      super parent, opt
    end

    def filter_text
      @filter_text ||= ""
    end

    def filter(_filter_text)
      @filter_text = _filter_text
      cursor.clear
      in_pos(0, 0) { update }
    end

    def update
      items.each_with_index do |item, index|
        setpos index, 0
        clrtoeol
      end
      refresh

      change_focus_line {
        view_collection.each_with_index do |item, index|
          draw_at index
        end
      }
    end

    def collection; items.filter(filter_text.to_s) end
    def selected_item; view_collection[cursor.y] end

    def on_input(ch)
      case ch
      when *KEYS[:up] then up
      when *KEYS[:down] then down
      end
    end
  end
end
