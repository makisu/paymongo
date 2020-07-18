# PayMongo Ruby Library
[![CircleCI](https://circleci.com/gh/makisu/paymongo.svg?style=svg)](https://circleci.com/gh/makisu/paymongo)

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

## Create a payment method

See: [Create a PaymentMethod](https://developers.paymongo.com/reference#create-a-paymentmethod)

```ruby
result = gateway.payment_method.create(
  line1: 'Unit 3308, High St South Corp Plaza',
  line2: '26th Street & 11th Avenue',
  city: 'Taguig',
  state: 'Metro Manila',
  postal_code: '1634',
  country: 'PH',
  email: 'juan@paymongo.com',
  name: 'Juan Dela Cruz',
  phone: '63288881111',
  card_number: '4343434343434345', # String
  exp_month: 1, # Cannot be zero-padded, Integer
  exp_year: 24, # Can use full year, 2024; Integer
  cvc: '999', # String
  type: 'card',
  metadata: {
    sample: '123'
  }
)
result.payment_method
```

## Get a payment method

See: [Retrieve a PaymentMethod](https://developers.paymongo.com/reference#retrieve-a-paymentmethod)

```ruby
result = gateway.payment_method.get('pm_sVDMnem4gYcxTtAnpGZHFXi2')
result.payment_method
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
result.transaction
```

## Running the test suite

1. Install the latest Ruby

2. Copy `config.yml.sample` to `config.yml` then run:
```
bundle install
bundle exec rspec spec
```

3. You can replace values in `config.yml` with values from your PayMongo
   dashboard

## Branch Organization
- `master` is the development branch
- `rubygems` contains code for the latest version of this gem

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/makisu/paymongo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
