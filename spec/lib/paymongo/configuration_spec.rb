require 'spec_helper'

module Paymongo
  RSpec.describe Configuration do
    describe '.new' do
      context 'config specified' do
        before do
          Paymongo.configure do |c|
            c.secret_key = 'secret_key'
            c.public_key = 'public_key'
          end
        end
        it 'accepts merchant credentials with specified config' do
          config = Paymongo::Configuration.new
          expect(config.secret_key).to eq('secret_key')
          expect(config.public_key).to eq('public_key')
        end
        it 'overrides merchant credentials from params' do
          config =
            Paymongo::Configuration.new(
              secret_key: 'override_secret_key',
              public_key: 'override_public_key'
            )
          expect(config.secret_key).to eq('override_secret_key')
          expect(config.public_key).to eq('override_public_key')
        end
      end
      context 'no config specified' do
        it 'accepts merchant credentials from params' do
          config =
            Paymongo::Configuration.new(
              secret_key: 'my_secret_key', public_key: 'my_public_key'
            )
          expect(config.secret_key).to eq('my_secret_key')
          expect(config.public_key).to eq('my_public_key')
        end
      end
    end

    describe 'self.public_key' do
      it "raises an exception if it hasn't been set yet" do
        Paymongo::Configuration.instance_variable_set(:@public_key, nil)
        expect { Paymongo::Configuration.public_key }.to raise_error(
          Paymongo::ConfigurationError,
          'Paymongo::Configuration.public_key needs to be set'
        )
      end
      it 'raises an exception if it is an empty string' do
        Paymongo::Configuration.instance_variable_set(:@public_key, '')
        expect { Paymongo::Configuration.public_key }.to raise_error(
          Paymongo::ConfigurationError,
          'Paymongo::Configuration.public_key needs to be set'
        )
      end
    end

    describe 'self.secret_key' do
      it "raises an exception if it hasn't been set yet" do
        Paymongo::Configuration.instance_variable_set(:@secret_key, nil)
        expect { Paymongo::Configuration.secret_key }.to raise_error(
          Paymongo::ConfigurationError,
          'Paymongo::Configuration.secret_key needs to be set'
        )
      end
      it 'raises an exception if it is an empty string' do
        Paymongo::Configuration.instance_variable_set(:@secret_key, '')
        expect { Paymongo::Configuration.secret_key }.to raise_error(
          Paymongo::ConfigurationError,
          'Paymongo::Configuration.secret_key needs to be set'
        )
      end
    end

    describe 'self.port' do
      it 'is 443' do
        expect(Paymongo::Configuration.instantiate.port).to eq(443)
      end
    end

    describe 'self.protocol' do
      it 'is always https' do
        expect(Paymongo::Configuration.instantiate.protocol).to eq('https')
      end
    end

    describe 'server' do
      it 'is always api.paymongo.com' do
        expect(Paymongo::Configuration.instantiate.server).to eq(
          'api.paymongo.com'
        )
      end
    end

    describe 'ssl?' do
      it 'always returns true' do
        expect(Paymongo::Configuration.instantiate.ssl?).to eq(true)
      end
    end

    describe 'inspect' do
      it 'masks the secret key' do
        config = Paymongo::Configuration.new(secret_key: 'sk_foobar')
        expect(config.inspect).to include('@secret_key="[FILTERED]"')
        expect(config.inspect).to_not include('sk_foobar')
      end
    end
  end
end
