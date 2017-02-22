module Koine
  class Profiler
    class Entries
      def initialize()
        @storage = Hash.new
      end

      def append(name, time)
        group = by_name(name) || create_group(name)
        append_to_group(group, name, time)
      end

      def by_name(name)
        storage[name.to_s]
      end

      def size
        storage.size
      end

      def total_elapsed_time
        storage.inject(0) do |total, (key, group)|
          total + group.total_elapsed_time
        end
      end

      private

      def create_group(name)
        storage[name.to_s] = EntryGroup.new(name)
      end

      def append_to_group(group, name, time)
        group.append(Entry.new(name, time))
      end

      attr_reader :storage
    end
  end
end
