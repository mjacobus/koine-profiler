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
      value = nil
      start_time = Time.now.utc
      value = yield if block_given?
      finish_time = Time.now.utc

      entries.append(name, finish_time - start_time)
      value
    end
  end
end
