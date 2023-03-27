# SeatableRuby

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/seatable_ruby`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add seatable_ruby

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install seatable_ruby

## Usage

- create a file with any name (whatever you like) in the `initializers` folder.
- add the following lines to this file:
    ```
    require 'seatable_ruby'

    SeatableRuby.config do |c|
        c.api_token = ENV['SEATABLE_API_TOKEN']
    end    
    ```
__NOTICE:__ Put your api_token into `ENV['SEATABLE_API_TOKEN']`. You can do it by using the [dotenv-rails gem](https://github.com/bkeepers/dotenv) **OR** use `master.key` and `credentials.yml.enc` if you rails version is `5.0 +`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viktorMarkevich/seatable_ruby.
