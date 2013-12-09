# -*- coding: utf-8 -*-

module RubyAnything
  require "curses"
  require "ruby-anything/version"
  require "ruby-anything/windows"
  require "ruby-anything/kernel_ext"

  def self.execute(ary)
    unless ary.respond_to? :to_a
      raise ArgumentError, "Invalid argument `#{ary}` for RubyAnything.execute. This argument must be Array"
    end
    unless ary.all? { |e| e.respond_to?(:to_s) }
      raise ArgumentError, "Invalid argument `#{ary}` for RubyAnything.execute. This argument's element must have `to_s` method"
    end

    isatty = STDOUT.isatty

    unless isatty
      stdout_old = STDOUT.dup
      STDOUT.reopen('/dev/tty')
    end

    Windows.anything ary.map(&:to_s)
  ensure
    unless isatty
      STDOUT.flush
      STDOUT.reopen stdout_old
    end
  end
end
