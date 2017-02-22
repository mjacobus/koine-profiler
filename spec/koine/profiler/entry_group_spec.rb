require 'spec_helper'

RSpec.describe Koine::Profiler::EntryGroup do
  subject { Koine::Profiler::EntryGroup.new('the given name') }

  describe '#name' do
    it 'returns the constructor given name' do
      expect(subject.name).to eq('the given name')
    end
  end

  describe '#entries' do
    it 'is initially empt' do
      expect(subject.entries).to eq([])
    end
  end

  describe '#append' do
    it 'adds the element to the entries' do
      entry = create_entry(1)

      subject.append(entry)

      expect(subject.entries).to eq([entry])
    end

    it 'raises an error when the entry does not have the same name as the group' do
      entry = create_entry(1, 'another name')

      expect do
        subject.append(entry)
      end.to raise_error(Koine::Profiler::EntryGroup::InvalidEntryError)
    end
  end

  describe '#total_elapsed_time' do
    it 'is initially zero' do
      expect(subject.total_elapsed_time).to eq(0)
    end

    it 'returs the sum of all elapsed times' do
      subject.append(create_entry(1))
      subject.append(create_entry(11))

      expect(subject.total_elapsed_time).to eq(12)
    end
  end


  describe '#==' do
    let(:other) { create_entry_group_with_initial_entry(10) }

    it "returns true when elements are the same" do
      entry = create_entry_group_with_initial_entry(10)

      expect(entry).to eq(other)
    end

    it "returns false when name is different" do
      entry = create_entry_group_with_initial_entry(10, 'other name')

      expect(entry).not_to eq(other)
    end

    it "returns false when elapsed time is different" do
      entry = create_entry_group_with_initial_entry(11)

      expect(entry).not_to eq(other)
    end
  end

  it 'is sortable by elapsed time' do
    unsorted = [
      create_entry_group_with_initial_entry(20),
      create_entry_group_with_initial_entry(25),
      create_entry_group_with_initial_entry(10),
    ]

    expected = [
      create_entry_group_with_initial_entry(10),
      create_entry_group_with_initial_entry(20),
      create_entry_group_with_initial_entry(25),
    ]

    sorted = unsorted.sort

    expect(sorted).to eq(expected)
  end
end
