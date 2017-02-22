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
end

