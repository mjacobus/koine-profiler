require 'spec_helper'

RSpec.describe Koine::Profiler::Reporters::Cli do
  context '#report' do
    let(:table) { [] }
    let(:output) { [] }
    subject(:reporter) { described_class.new(output, table) }

    let(:entries) { [first, second] }
    let(:first) { Koine::Profiler::Entry.new('first') }
    let(:second) { Koine::Profiler::Entry.new('second') }

    before do
      first.increment(elapsed_time: 1, memory_used: 2)
      second.increment(elapsed_time: 1, memory_used: 2)
      second.increment(elapsed_time: 2, memory_used: 2)
    end


    it 'outputs all the calls to the terminal' do
      reporter.report(entries)

      expected_table = [
        ['Entry', 'Elapsed Time', '# of calls'],
        ['first', 1, 1],
        ['second', 3, 2],
      ]

      expect(table).to eq(expected_table)
      expect(output).to eq([expected_table])
    end
  end
end
