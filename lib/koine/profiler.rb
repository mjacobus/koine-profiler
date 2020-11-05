require 'koine/profiler/version'
require 'koine/profiler/entries'
require 'koine/profiler/entry_group'
require 'koine/profiler/entry'
require 'koine/profiler/profile_entry'

module Koine
  class Profiler
    attr_reader :entries

    def initialize
      @entries = {}
    end

    def profile(name)
      value = nil
      start_time = Time.now.utc
      value = yield if block_given?
      finish_time = Time.now.utc

      add_entry(name, time: finish_time - start_time, memory: 0)
      value
    end

    private

    def add_entry(name, time:, memory:)
      entry = @entries[name] ||= ProfileEntry.new(name)
      entry.increment(elapsed_time: time, memory_used: memory)
    end
  end
end
