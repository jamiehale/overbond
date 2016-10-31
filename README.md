# Overbond

This is a technical screen exercise for a job application.

It consists of a single program ("overbond") with multiple commands that solve the technical screen problems.

## Installation

Since this is only an exercise, I haven't published it to a gem repository. Installation is manual. After cloning the repo (or unpacking a .zip):

    $ bundle install
    $ rake build
    $ gem install pkg/overbond-0.1.0.gem

Alternatively, without building and installing the gem:

    $ bundle install
    $ bundle exec overbond ...

## Usage

The overbond program has 2 commands: benchmark and spread_to_curve.

    $ overbond benchmark INPUT_FILE

Loops through each corporate bond in INPUT_FILE, finds the appropriate benchmark government bond (also in INPUT_FILE), and reports the spread between them.

    $ overbond spread_to_curve INPUT_FILE

Loops through each corporate bond in INPUT_FILE, and calculates and reports the spread to the curve created by the benchmark government bonds (also in INPUT_FILE).

## Development

After checking out the repo, run:

    $ bin/setup
    
to install dependencies. Then, run:

    $ bundle exec rspec
    $ bundle exec cucumber
    $ rake rubocop

to run the tests, coverage (part of the rspec run), and style-cop reports.

## Design

The application builds on Thor for CLI. It includes 2 commands (as above). Each command is implemented in its own class (BenchmarkCommand and SpreadToCurveCommand) to keep the CLI class as clean as possible.

Each command delegates file input to the BondFileLoader which returns a BondCollection - an array of Bonds with extra methods for easy querying.

BondCollection queries are currently limited to what was required for this particular challenge, and likely show my lack of understanding of the entire domain.

Benchmark location is performed by the BenchmarkFinder. It returns BenchmarkSpreads with calculated spreads and references to the Bond and benchmark in question.

Benchmark curves are implemented in the YieldCurve and consist of YieldCurveLegs - effectively line segments in the chart with a Bond defining endpoints. YieldCurves know how to calculate distance from the entire curve (by selecting the closest leg) to other Bonds, and YieldCurveLegs know how to calculate the distance from its segment to a Bond.

Reporter classes (BenchmarkSpreadReporter and SpreadCurveReporter) encapsulate formatted output. Alternative streams (other than STDOUT - the default) can be passed if required.

Full linked documentation can be built with:

    $ bundle exec rdoc

### Techniques

Following the 'S' from the SOLID principles, each class has a single resposibility to decrease coupling and ensure each class has only one reason to change. The command classes use the 'D' - dependency inversion principle - to facilitate testing by allowing references to be passed to the constructor *or* if not passed, creating the necessary default references.

Thor was chosen as a CLI base for its flexibility and widespread use (and hence testing).

File loading is split into a class of its own to enable very simple replacement with a database backend.

All code is packaged as a gem for easy reuse in other programs.

Standard Ruby gem patterns and tools (bundler, rspec, cucumber, simplecov, rubocop) were used to ensure other developers' familiarity and ease of use.

### Future

I'm probably using domain language incorrectly all over the place. With more time, it would be worthwhile to rename things as appropriate, and add error checking to things like bond types and ids answering questions like:

  * Are there only 2 types of bonds to consider?
  * Are corporate bonds always named "C#"? And government bonds always "G#"?

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jamiehale/overbond.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

