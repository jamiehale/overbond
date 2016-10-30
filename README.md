# Overbond

This is a technical screen exercise for a job application.

It consists of a single program ("overbond") with multiple commands that solve the technical screen problems.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'overbond'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install overbond

## Usage

The overbond program has 2 commands: benchmark and spread_to_curve.

    $ overbond benchmark INPUT_FILE

Loops through each corporate bond in INPUT_FILE, finds the appropriate benchmark government bond (also in INPUT_FILE), and reports the spread between them.

    $ overbond spread_to_curve INPUT_FILE

Loops through each corporate bond in INPUT_FILE, and calculates and reports the spread to the curve created by the benchmark government bonds (also in INPUT_FILE).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` and `bundle exec cucumber` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jamiehale/overbond.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

