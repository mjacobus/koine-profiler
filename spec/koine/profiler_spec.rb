require 'spec_helper'

RSpec.describe Koine::Profiler do
  subject(:profiler) { described_class.new }

  it 'has a version number' do
    expect(Koine::Profiler::VERSION).not_to be nil
  end

  describe '#profile' do
    it 'returns what was in the block' do
      value = profiler.profile('something') do
        10
      end

      expect(value).to be(10)
    end

    it 'can profile with a name and a block' do
      data = nil
      now = Time.now.utc
      first_time = Time.now.utc
      second_time = Time.now.utc + 10

      def second_time.-(_other)
        10
      end

      allow(Time).to receive(:now).and_return(now)
      allow(now).to receive(:utc).and_return(first_time, second_time)

      profiler.profile('test profile') do
        data = 'foo'
      end

      expect(data).to eq('foo')
      expect(profiler.entries.size).to eq(1)
      expect(profiler.entries.first.name).to eq('test profile')
      expect(profiler.entries.first.elapsed_time).to eq(10)
      expect(profiler.entries.first.memory_used).to eq(0)
    end
  end

  describe '#entries' do
    it 'returns the number of entries as an array' do
      profiler.profile('test profile') do
        # do work
      end

      expect(profiler.entries.map(&:name)).to eq(['test profile'])
    end
  end

  it 'has an singleton instance' do
    expect(described_class.instance).to be_a(described_class)
    expect(described_class.instance).to be(described_class.instance)
  end
end
