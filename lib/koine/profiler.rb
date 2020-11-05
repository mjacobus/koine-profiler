require 'koine/profiler/version'
require 'koine/profiler/entry'

module Koine
  class Profiler
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

    def entries
      @entries.values
    end

    def self.instance
      @instance ||= new
    end

    private

    def add_entry(name, time:, memory:)
      entry = @entries[name] ||= Entry.new(name)
      entry.increment(elapsed_time: time, memory_used: memory)
    end
  end
end
