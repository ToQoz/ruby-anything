module RubyAnything
  module Filterable
    def filter(text)
      patterns = text.split(/\s+/).map do |word|
        /#{word}/i
      end

      select do |e|
        patterns.empty? || patterns.all? { |p| p =~ e }
      end
    end
  end
end
