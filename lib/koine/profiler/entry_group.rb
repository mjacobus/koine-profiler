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
        raise InvalidEntryError.new(entry.name) unless entry.name == name

        @entries << entry
      end

      def total_elapsed_time
        entries.inject(0) { |total, entry| entry.elapsed_time + total }
      end
    end
  end
end
