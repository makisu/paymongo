# PayMongo Ruby Library
[![Build
Status](https://travis-ci.org/makisu/paymongo_ruby.svg?branch=master)](https://travis-ci.com/makisu/paymongo_ruby)

Charge credit cards using [PayMongo](https://developers.paymongo.com/) in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paymongo'
```

Or install it yourself as:

```ruby
gem install paymongo
```

## Usage

In an initializer, you can set default values:

```ruby
Paymongo.configure do |c|
  c.secret_key = "PAYMONGO-SK-API-KEY"
  c.public_key = "PAYMONGO-PK-API-KEY"
end
```

## Initializing a Gateway

This is the instance that you will be interacting with to create payments.

```ruby
# This gateway grabs defaults from config
gateway = Paymongo::Gateway.new(Paymongo::Configuration.new)

# Only to override the defaults that were set in the config
gateway = Paymongo::Gateway.new(
  secret_key: "...",
  public_key: "..."
)
```

## Charge a Card

```ruby
result = gateway.transaction.sale(
  token: token_from_the_client,
  amount: 10000,
  currency: "PHP",
  # Below are optional
  description: "Payment for Invoice #0001",
  statement_descriptor: "MAKISU.CO"
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/makisu/paymongo_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
