require 'bundler/setup'
require 'koine/profiler'
require 'koine/profiler/reporters/cli'

MAX = 1_000_000

reporter = Koine::Profiler::Reporters::Cli.new
profiler = Koine::Profiler.instance

profiler.profile('arrays integers') do
  data = []
  1.upto(MAX).each do |num|
    profiler.profile('arrays integers item') do
      data << num
    end
  end
  data.length
end

profiler.profile('arrays hashes') do
  data = []
  1.upto(MAX).each do |num|
    profiler.profile('arrays hashes item') do
      data << { num: num }
    end
  end
  data.length
end

reporter.report(profiler.entries)
