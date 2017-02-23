module Koine
  class Profiler
    class EntryGroup
      InvalidEntryError = Class.new(StandardError)

      attr_reader :name, :entries

      def initialize(name)
        @name = name.to_s
        @entries = []
      end

      def append(entry)
        fail InvalidEntryError.new(entry.name) unless entry.name == name

        entries << entry
      end

      def ==(other)
        entries == other.entries
      end

      def <=>(other)
        elapsed_time <=> other.elapsed_time
      end

      def elapsed_time
        entries.inject(0) { |total, entry| entry.elapsed_time + total }
      end
    end
  end
end
