module Koine
  class Profiler
    class Entry
      attr_reader :name, :elapsed_time

      def initialize(name, elapsed_time)
        @name = name.to_s
        @elapsed_time = elapsed_time
      end

      def ==(other)
        other.name == name && other.elapsed_time == elapsed_time
      end

      def <=>(other)
        elapsed_time <=> other.elapsed_time
      end
    end
  end
end
