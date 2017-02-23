require 'forwardable'

module Koine
  class Profiler
    class Entries
      extend Forwardable

      def_delegators :storage, :size
      def_delegators :to_a, :each

      def initialize(groups = [])
        @storage = {}
        groups.each { |group| append_group(group) }
      end

      def append(name, time)
        group = find_by_name(name) || create_group(name)
        append_to_group(group, name, time)
      end

      def find_by_name(name)
        storage[name.to_s]
      end

      def elapsed_time
        storage.inject(0) do |total, (_key, group)|
          total + group.elapsed_time
        end
      end

      def sort_by(&_block)
        sorted = storage.sort_by { |item| yield(item[1]) }.map { |_key, group| group }
        create(sorted)
      end

      def reverse
        create(storage.to_a.reverse.map { |_key, group| group })
      end

      def slowest
        sort_by(&:elapsed_time).reverse
      end

      def to_a
        storage.values
      end

      def limit(number)
        create(to_a.slice(0, number.to_i))
      end

      def ==(other)
        storage.to_a == other.storage.to_a
      end

      private

      def create(groups = [])
        self.class.new(groups)
      end

      def create_group(name)
        append_group(EntryGroup.new(name))
      end

      def append_group(group)
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
