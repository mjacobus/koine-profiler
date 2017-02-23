require 'spec_helper'

RSpec.describe Koine::Profiler::Entries do
  let(:ten)       { create_group_with_entries('ten', 9, 1) }
  let(:fifteen)   { create_group_with_entries('fifteen', 9, 6) }
  let(:twenty)    { create_group_with_entries('twenty', 9, 10) }
  let(:entries) {
    described_class.new([
      fifteen,
      ten,
      twenty,
    ])
  }

  specify '#size is initially zero' do
    expect(subject.size).to eq(0)
  end

  specify '#each iterates every item' do
    collection = []

    entries.each do |entry|
      collection << entry
    end

    expect(collection).to eq([fifteen, ten, twenty ])
  end

  specify '#limit limits the result' do
    expect(entries.limit('2').to_a).to eq([fifteen, ten])
  end

  describe '#find_by_name' do
    context  'when has no entry group' do
      it 'returns nil' do
        expect(subject.find_by_name('unexisting')).to be_nil
      end
    end

    describe 'when has an entry group' do
      it 'returns the existing group' do
        expected_group = create_entry_group_with_initial_entry(10, 'foo')

        subject.append('foo', 10)
        group = subject.find_by_name('foo')

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
    expect(subject.find_by_name('foo').elapsed_time).to eq(30)
    expect(subject.find_by_name('bar').elapsed_time).to eq(70)
  end

  specify '#elapsed_time returns the some of elapsed time' do
    subject.append('foo', 10)
    subject.append('foo', 20)
    subject.append('bar', 30)

    expect(subject.elapsed_time).to eq(60)
  end

  specify '#to_a returns array of items' do
    one = create_group_with_entries('one', 9, 1)
    two = create_group_with_entries('two', 9, 1, 1)

    expected = [one, two]

    entries = described_class.new(expected)

    expect(entries.to_a).to eq(expected)
  end

  describe "sorting" do
    specify '#sort_by takes item as block argument' do
      expected = described_class.new([
        fifteen,
        ten,
        twenty,
      ])

      sorted = entries.sort_by { |item| item.name }
      sorted_with_shortcut = entries.sort_by(&:name)

      expect(sorted).to eq(expected)
      expect(sorted_with_shortcut).to eq(expected)
    end

    specify '#slowest reorders and gives a new object' do
      expected = described_class.new([
        twenty,
        fifteen,
        ten,
      ])

      actual = entries.slowest

      expect(actual).to eq(expected)
    end

    specify '#reverse reverses the order' do
      expected = described_class.new([
        twenty,
        ten,
        fifteen,
      ])

      actual = entries.reverse

      expect(actual).to eq(expected)
    end
  end
end
