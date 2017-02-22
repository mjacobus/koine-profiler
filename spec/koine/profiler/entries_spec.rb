require 'spec_helper'

RSpec.describe Koine::Profiler::Entries do
  def create_entry_group(name)
    Koine::Profiler::EntryGroup.new(name)
  end

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
        subject.append('foo', 10)

        group_name = 'foo'
        group = create_entry_group(group_name)

        found_group = subject.by_name(group_name)

        expect(found_group).to be_a(group.class)
        expect(found_group.name).to eq('foo')
      end
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
end
