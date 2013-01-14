# -*- coding: utf-8 -*-

module RubyAnything
  class PromptWindow < BaseWindow
    def initialize(parent, prompt, opt)
      @prompt = prompt
      super(parent, opt)
    end
    def view_collection; [ @prompt ] end
    def draw_at(*args)
      in_color(PROMPT_COLOR) {
        super(*args)
      }
    end
  end
end
