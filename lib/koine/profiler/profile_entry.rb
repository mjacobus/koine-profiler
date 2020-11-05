# frozen_string_literal: true

module Koine
  class Profiler
    class ProfileEntry
      attr_reader :name
      attr_reader :elapsed_time
      attr_reader :memory_used
      attr_reader :hits

      def initialize(name)
        @name = name
        @elapsed_time = 0
        @memory_used = 0
        @hits = 0
      end

      def increment(elapsed_time:, memory_used:)
        @hits += 1
        @elapsed_time += elapsed_time
        @memory_used += memory_used
      end
    end
  end
end
