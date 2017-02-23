require "spec_helper"

RSpec.describe Koine::Profiler do
  it "has a version number" do
    expect(Koine::Profiler::VERSION).not_to be nil
  end

  context '#profile' do
    it 'returns what was in the block' do
      value = subject.profile('something') do
        10
      end

      expect(value).to be(10)
    end

    it "can profile with a name and a block" do
      data = nil
      now = Time.now.utc
      first_time = Time.now.utc
      second_time = Time.now.utc + 10

      def second_time.-(other)
        10
      end

      allow(Time).to receive(:now).and_return(now)
      allow(now).to receive(:utc).and_return(first_time, second_time)

      subject.profile('test profile') do
        data = 'foo'
      end

      expected_entries = Koine::Profiler::Entries.new([
        create_group_with_entries('test profile', 10)
      ])

      expect(data).to eq('foo')
      expect(subject.entries).to eq(expected_entries)
    end
  end
end
