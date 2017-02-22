require 'spec_helper'

RSpec.describe Koine::Profiler::Entries do
  specify '#size is initially zero' do
    expect(subject.size).to eq(0)
  end

  describe '#by_name' do
    context  'when has no entry group' do
      it 'returns nil' do
        expect(subject.by_name('unexisting')).to be_nil
      end
    end

    describe 'when has an entry group' do
      it 'returns the existing group' do
        expected_group = create_entry_group_with_initial_entry(10, 'foo')

        subject.append('foo', 10)
        group = subject.by_name('foo')

        expect(group).to eq(expected_group)
        expect(group).to be_a(expected_group.class)
        expect(group.name).to eq('foo')
      end
    end
  end

  describe '==' do
    it 'returns true when elements are equal' do
      entry = described_class.new([create_group_with_entries('ten', 9, 1)])
      other = described_class.new([create_group_with_entries('ten', 9, 1)])

      expect(entry).to eq(other)
    end

    it 'returns false when elements are different' do
      entry = described_class.new([create_group_with_entries('ten', 9, 1)])
      other = described_class.new([create_group_with_entries('ten', 2, 8)])

      expect(entry).not_to eq(other)
    end
  end

  specify '#append creates at least one new group and a one new entry' do
    subject.append('foo', 10)
    subject.append('foo', 20)
    subject.append('bar', 30)
    subject.append('bar', 40)

    expect(subject.size).to eq(2)
    expect(subject.by_name('foo').total_elapsed_time).to eq(30)
    expect(subject.by_name('bar').total_elapsed_time).to eq(70)
  end

  specify '#total_elapsed_time returns the some of elapsed time' do
    subject.append('foo', 10)
    subject.append('foo', 20)
    subject.append('bar', 30)

    expect(subject.total_elapsed_time).to eq(60)
  end

  describe "sorting" do
    let(:ten)       { create_group_with_entries('ten', 9, 1) }
    let(:fifteen)   { create_group_with_entries('fifteen', 9, 6) }
    let(:twenty)    { create_group_with_entries('twenty', 9, 10) }
    let(:unordered) {
      described_class.new([
        fifteen,
        ten,
        twenty,
      ])
    }

    specify '#desc reorders and gives a new object' do
      expected = described_class.new([
        twenty,
        fifteen,
        ten,
      ])

      actual = unordered.desc

      expect(actual).to eq(expected)
    end

    specify '#desc reorders and gives a new object' do
      expected = described_class.new([
        ten,
        fifteen,
        twenty,
      ])

      actual = unordered.asc

      expect(actual).to eq(expected)
    end
  end
end
