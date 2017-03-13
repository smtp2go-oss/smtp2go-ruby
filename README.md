# Smtp2go

Library for interfacing with the [https://apidoc.smtp2go.com/documentation/#/README](SMTP2Go API)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smtp2go'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smtp2go

## Usage

Sign up for a free account [here](https://www.smtp2go.com/pricing) and get an API key. At your shell, run:

    $ export SMTP2GO_API_KEY="<your_API_key>"

Then sending mail is as simple as:

    require 'smtp2go'

    smtp2go_client = Smtp2go::Smtp2goClient.new

    payload = {
      :sender=>"dave@example.com",
      :recipients=>["matt@example.com"],
      :subject=>"Trying out smtp2go!",
      :message=>"Test Message"
    }

    response = smtp2go_client.send(payload)

Full API documentation can be found [here](https://apidoc.smtp2go.com/documentation/#/README)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smtp2go-oss/smtp2go.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
