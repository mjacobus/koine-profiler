if ENV['TRAVIS']
  require "coveralls"
  Coveralls.wear!
end

require "simplecov"

SimpleCov.start do
  add_filter "/spec/"
end

require "bundler/setup"
require "koine/profiler"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def create_entry_group(name)
  Koine::Profiler::EntryGroup.new(name)
end


def create_entry(elapsed_time, name = 'the given name')
  Koine::Profiler::Entry.new(name, elapsed_time)
end

def create_entry_group_with_initial_entry(elapsed_time, name = 'foo')
  group = Koine::Profiler::EntryGroup.new(name)
  group.append(create_entry(elapsed_time, name))
  group
end

def create_group_with_entries(name, *elapsed_times)
  group = create_entry_group(name)
  elapsed_times.each do |elapsed_time|
    group.append(create_entry(elapsed_time, name))
  end
  group
end
