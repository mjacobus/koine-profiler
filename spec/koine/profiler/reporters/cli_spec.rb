require 'spec_helper'

RSpec.describe Koine::Profiler::Reporters::Cli do
  context '#report' do
    let(:table) { [] }
    let(:output) { [] }
    subject { described_class.new(output, table) }

    let(:entries) do
      Koine::Profiler::Entries.new([
        create_group_with_entries('first', 1),
        create_group_with_entries('second', 1, 2),
        create_group_with_entries('third', 1, 2, 3),
      ])
    end

    it 'outputs all the calls to the terminal' do
      subject.report(entries)

      expected_table = [
        ['Entry', 'Elapsed Time', '# of calls'],
        ['first', 1, 1],
        ['second', 3, 2],
        ['third', 6, 3],
      ]

      expect(table).to eq(expected_table)
      expect(output).to eq([expected_table])
    end
  end
end
