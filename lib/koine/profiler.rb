require 'koine/profiler/version'
require 'koine/profiler/entry'
require 'get_process_mem'

module Koine
  class Profiler
    def initialize
      @entries = {}
    end

    def profile(name)
      value = nil
      start_time = Time.now.utc
      start_memory = GetProcessMem.new.mb
      value = yield if block_given?
      finish_memory = GetProcessMem.new.mb
      finish_time = Time.now.utc
      add_entry(
        name,
        time: finish_time - start_time,
        memory: finish_memory - start_memory
      )
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
