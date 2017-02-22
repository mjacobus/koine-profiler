module Koine
  class Profiler
    class Entry
      attr_reader :name, :elapsed_time

      def initialize(name, elapsed_time)
        @name, @elapsed_time = name.to_s, elapsed_time
      end
    end
  end
end

