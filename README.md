[![Build Status](https://travis-ci.org/smtp2go-oss/smtp2go-ruby.svg?branch=master)](https://travis-ci.org/smtp2go-oss/smtp2go-ruby)
[![Coverage Status](https://coveralls.io/repos/github/smtp2go-oss/smtp2go-ruby/badge.svg?branch=master)](https://coveralls.io/github/smtp2go-oss/smtp2go-ruby?branch=master)
[![Gem Version](https://badge.fury.io/rb/smtp2go.svg)](https://badge.fury.io/rb/smtp2go)
[![Dependency Status](https://gemnasium.com/badges/github.com/smtp2go-oss/smtp2go-ruby.svg)](https://gemnasium.com/github.com/smtp2go-oss/smtp2go-ruby)
[![Code Climate](https://codeclimate.com/github/smtp2go-oss/smtp2go-ruby/badges/gpa.svg)](https://codeclimate.com/github/smtp2go-oss/smtp2go-ruby)
[![Issue Count](https://codeclimate.com/github/smtp2go-oss/smtp2go-ruby/badges/issue_count.svg)](https://codeclimate.com/github/smtp2go-oss/smtp2go-ruby)
[![license](https://img.shields.io/github/license/smtp2go-oss/smtp2go-ruby.svg)]()

# smtp2go

Library for interfacing with the [smtp2go API](https://apidoc.smtp2go.com/documentation/#/README)

We also have a [Ruby on Rails Library ](https://github.com/smtp2go-oss/smtp2go-rails)

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

Here is a REPL session showing a successful send and probing of the response object:

    [1] pry(main)> require 'smtp2go'
    => true
    [2] pry(main)> client = Smtp2go::Smtp2goClient.new
    => #<Smtp2go::Smtp2goClient:0x007fb6ee17b108
     @api_key="<redacted>",
     @headers=
      {"Content-Type"=>"application/json",
       "X-Smtp2go-Api"=>"smtp2go-ruby",
    [3] pry(main)> payload = {
    [3] pry(main)*>   sender: 'dave@example.com',
    [3] pry(main)*>   recipients: ['matt@example.com'],
    [3] pry(main)*>   subject: 'Test Message',
    [3] pry(main)*>   text: 'Test message',
    [3] pry(main)*>   html: '<html><body><h1>Test HTML message</h1></body></html>'}</html>'}
    => {:sender=>'dave@example.com',
     :recipients=>['matt@example.com'],
     :subject=>'Test Message',
     :text=>'Test message',
     :html=>'<html><body><h1>Test HTML message</h1></body></html>'}</html>'}
    [4] pry(main)> response = client.send payload
    => #<Smtp2go::Smtp2goResponse:0x007fb6ee268840
     @rate_limit=
      #<Smtp2go::RateLimit:0x007fb6ee268818
       @limit="250",
       @remaining="250",
       @reset="51">,
     @response=
      {"request_id"=>"<redacted>",
       "data"=>{"failures"=>[], "succeeded"=>1, "failed"=>0}}>
    [5] pry(main)> response.rate_limit
    => #<Smtp2go::RateLimit:0x007fb6ee268818
     @limit="250",
     @remaining="250",
     @reset="51">
    [6] pry(main)> response.success?
    => true
    [7] pry(main)> response.errors
    => nil
    [8] pry(main)> response.json
    => {"request_id"=>"<redacted>",
     "data"=>{"failures"=>[], "succeeded"=>1, "failed"=>0}}
    [9] pry(main)>

Full API documentation can be found [here](https://apidoc.smtp2go.com/documentation/#/README), with Ruby specific docs [here](http://www.rubydoc.info/gems/smtp2go/0.0.1) 


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smtp2go-oss/smtp2go-ruby.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
