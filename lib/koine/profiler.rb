require "koine/profiler/version"
require "koine/profiler/entries"
require "koine/profiler/entry_group"
require "koine/profiler/entry"

module Koine
  class Profiler
    attr_reader :entries

    def initialize
      @entries = Entries.new
    end

    def profile(name)
      start_time = Time.now.utc
      yield if block_given?
      finish_time = Time.now.utc

      entries.append(name, finish_time - start_time)
    end
  end
end
