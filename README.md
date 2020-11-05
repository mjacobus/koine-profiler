# Koine::Profiler

Simple profiler

[![Build Status](https://travis-ci.org/mjacobus/koine-profiler.svg?branch=master)](https://travis-ci.org/mjacobus/koine-profiler)
[![Code Coverage](https://scrutinizer-ci.com/g/mjacobus/koine-profiler/badges/coverage.png?b=master)](https://scrutinizer-ci.com/g/mjacobus/koine-profiler/?branch=master)
[![Code Climate](https://codeclimate.com/github/mjacobus/koine-profiler/badges/gpa.svg)](https://codeclimate.com/github/mjacobus/koine-profiler)
[![Gem Version](https://badge.fury.io/rb/koine-profiler.svg)](https://badge.fury.io/rb/koine-profiler)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'koine-profiler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install koine-profiler

## Usage

```ruby
profiler = Koine::Profiler.new

profiler.profile('some potentially slow task') do
  potentially_slow()
end

profiler.profile('require rails/all') do
  require 'rails/all'
end
```

### Reporting

```ruby
require 'koine/profiler/reporters/cli'

reporter = Koine::Profiler::Reporters::Cli.new

reporter.report(reporter.entries)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjacobus/koine-profiler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

