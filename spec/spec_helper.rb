if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

class MyProfiler < Koine::Profiler
  def self.instance
    @instance ||= Koine::Profiler.new
  end
end

require 'bundler/setup'
require 'koine/profiler'
require 'koine/profiler/reporters/cli'
require 'object_comparator/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def create_entry_group(name)
  profile('create_entry_group') do
    Koine::Profiler::EntryGroup.new(name)
  end
end

def create_entry(elapsed_time, name = 'the given name')
  profile('create_entry') do
    Koine::Profiler::Entry.new(name, elapsed_time)
  end
end

def create_entry_group_with_initial_entry(elapsed_time, name = 'foo')
  profile('create_entry_group_with_initial_entry') do
    group = Koine::Profiler::EntryGroup.new(name)
    group.append(create_entry(elapsed_time, name))
    group
  end
end

def create_group_with_entries(name, *elapsed_times)
  profile('create_group_with_entries') do
    group = create_entry_group(name)
    elapsed_times.each do |elapsed_time|
      group.append(create_entry(elapsed_time, name))
    end
    group
  end
end

def profiler
  MyProfiler.instance
end

def profile(name, &block)
  profiler.profile(name, &block)
end
