# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::Profiler::ProfileEntry do
  subject(:entry) { described_class.new('the-name') }

  it 'has a name' do
    expect(entry.name).to eq('the-name')
  end

  it 'hits can be added' do
    entry.increment(elapsed_time: 20, memory_used: 50)
    entry.increment(elapsed_time: 10, memory_used: 40)

    expect(entry.hits).to eq(2)
    expect(entry.elapsed_time).to eq(30)
    expect(entry.memory_used).to eq(90)
  end
end
