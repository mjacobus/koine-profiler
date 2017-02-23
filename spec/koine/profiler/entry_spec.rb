require 'spec_helper'

RSpec.describe Koine::Profiler::Entry do
  subject { Koine::Profiler::Entry.new('the given name', 1) }

  describe '#name' do
    it 'returns the name given in the construtor' do
      expect(subject.name).to eq('the given name')
    end
  end

  describe '#elapsed_time' do
    it 'returns the elapsed time given in the construtor' do
      expect(subject.elapsed_time).to eq(1)
    end
  end

  describe '#==' do
    let(:other) { described_class.new('foo', 1) }

    it 'returns false when name is different' do
      entry = described_class.new('bar', 1)

      expect(entry).not_to eq(other)
    end

    it 'returns false when elapsed time is different' do
      entry = described_class.new('foo', 2)

      expect(entry).not_to eq(other)
    end

    it 'returns true when name and elapsed time are equal' do
      entry = described_class.new('foo', 1)

      expect(entry).to eq(other)
    end
  end

  it 'is sortable by elapsed time' do
    unsorted = [
      described_class.new('foo', 20),
      described_class.new('foo', 25),
      described_class.new('foo', 10)
    ]

    expected = [
      described_class.new('foo', 10),
      described_class.new('foo', 20),
      described_class.new('foo', 25)
    ]

    sorted = unsorted.sort

    expect(sorted).to eq(expected)
  end
end
