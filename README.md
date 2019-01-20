# HindSight
A simple command line interface app built in Ruby.

HindSite has one function that can be called from the terminal `eod-history-for`.  The function takes a `date` and a `stock code` as arguments.  It returns a link to an image file that contains the total return and maximum drawdown for the given stock for a time period that begins with the given date and ends with the current date.

## Example
`eod-history-for 2018-10-20 HD` returns the calculated values for the `HD` stock from the time period which starts at `2018-10-20` and finishes at todays date.

## Getting Started
Requires Ruby 2.5 and Bundler
You will need a Quandl account
You will need a imgflip account

1. Clone the Repo
2. `cd hindsight`
3. `bundle install`
4. `touch config/api_key.rb`
5. fill out the new config file using `api_key.rb.example` as a guide.
6. `rspec` - make sure all the test are green :D
7. `bundle exec ruby app/hindsight.rb` to start the program
8. `eod-history-for` + date + stock code

## Notes
* There is currently no error handling for input so be sure to format dates correctly.
* Currenlty there are only unit tests.  An integration test, with mocked API calls, is probably worth adding.