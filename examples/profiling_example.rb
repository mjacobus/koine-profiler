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

# Output example:
#
# +----------------------+-------------------+--------------+---------+
# | Entry                | Elapsed Time      | Memory       | # hits  |
# | arrays integers item | 48.59363997100241 | 7.5625       | 1000000 |
# | arrays integers      | 50.281231385      | 8.14453125   | 1       |
# | arrays hashes item   | 64.81660490299825 | 152.8828125  | 1000000 |
# | arrays hashes        | 66.691896445      | 264.04296875 | 1       |
# +----------------------+-------------------+--------------+---------+
