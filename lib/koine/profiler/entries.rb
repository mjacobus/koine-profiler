require 'forwardable'

module Koine
  class Profiler
    class Entries
      extend Forwardable

      def_delegators :storage, :size

      def initialize(groups = [])
        @storage = Hash.new
        groups.each do |group|
          add_group(group)
        end
      end

      def append(name, time)
        group = by_name(name) || create_group(name)
        append_to_group(group, name, time)
      end

      def by_name(name)
        storage[name.to_s]
      end

      def total_elapsed_time
        storage.inject(0) do |total, (key, group)|
          total + group.total_elapsed_time
        end
      end

      def desc
        sorted = storage.sort_by do |key, item|
          item.total_elapsed_time
        end.to_h.values

        self.class.new(sorted)
      end

      def asc
        sorted = storage.sort_by do |key, item|
          item.total_elapsed_time
        end.reverse.to_h.values

        self.class.new(sorted)
      end

      def ==(other)
        storage == other.storage
      end

      private

      def create_group(name)
        add_group(EntryGroup.new(name))
      end

      def add_group(group)
        storage[group.name] = group
      end

      def append_to_group(group, name, time)
        group.append(Entry.new(name, time))
      end

      protected

      attr_reader :storage
    end
  end
end
