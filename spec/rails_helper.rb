# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

RATES = [
  { currency: 'JPY', rate: '132.56', date: '2018-09-24'.to_datetime },
  { currency: 'USD', rate: '132.56', date: '2018-09-24'.to_datetime },
  { currency: 'BGN', rate: '132.56', date: '2018-09-24'.to_datetime },
  { currency: 'CZK', rate: '132.56', date: '2018-10-19'.to_datetime },
  { currency: 'JPY', rate: '132.56', date: '2018-10-19'.to_datetime },
  { currency: 'USD', rate: '132.56', date: '2018-10-19'.to_datetime },
  { currency: 'BGN', rate: '132.56', date: '2018-11-09'.to_datetime },
  { currency: 'CZK', rate: '132.56', date: '2018-11-09'.to_datetime },
  { currency: 'JPY', rate: '132.56', date: '2018-11-09'.to_datetime },
  { currency: 'RON', rate: '132.56', date: '2018-12-21'.to_datetime },
  { currency: 'GBP', rate: '132.56', date: '2018-12-21'.to_datetime },
  { currency: 'HUF', rate: '132.56', date: '2018-12-22'.to_datetime },
  { currency: 'ISK', rate: '132.56', date: '2018-12-22'.to_datetime },
  { currency: 'NOK', rate: '132.56', date: '2018-04-24'.to_datetime },
  { currency: 'JPY', rate: '132.56', date: '2018-04-24'.to_datetime },
  { currency: 'GBP', rate: '132.56', date: '2018-06-15'.to_datetime },
  { currency: 'RUB', rate: '132.56', date: '2018-06-15'.to_datetime },
  { currency: 'HUF', rate: '132.56', date: '2018-06-15'.to_datetime },
  { currency: 'ISK', rate: '132.56', date: '2018-06-14'.to_datetime },
  { currency: 'RON', rate: '132.56', date: '2018-06-14'.to_datetime },
  { currency: 'USD', rate: '132.56', date: '2018-06-14'.to_datetime },
  { currency: 'CZK', rate: '132.56', date: '2018-06-14'.to_datetime },
  { currency: 'JPY', rate: '132.56', date: '2018-08-18'.to_datetime },
  { currency: 'ZAR', rate: '132.56', date: '2018-08-18'.to_datetime }
].freeze

XML_RATES = '<?xml version="1.0" encoding="UTF-8"?><gesmes:Envelope xmlns:gesmes="http://www.gesmes.org/xml/2002-08-01" xmlns="http://www.ecb.int/vocabulary/2002-08-01/eurofxref"><gesmes:subject>Reference rates</gesmes:subject>
<gesmes:Sender><gesmes:name>European Central Bank</gesmes:name></gesmes:Sender>
<Cube>
<Cube time="2018-10-01"><Cube currency="USD" rate="1.1606"/><Cube currency="JPY" rate="132.25"/><Cube currency="BGN" rate="1.9558"/><Cube currency="CZK" rate="25.765"/><Cube currency="DKK" rate="7.4557"/><Cube currency="GBP" rate="0.89078"/><Cube currency="HUF" rate="323.04"/><Cube currency="PLN" rate="4.2796"/><Cube currency="RON" rate="4.6605"/><Cube currency="SEK" rate="10.33"/><Cube currency="CHF" rate="1.1414"/><Cube currency="ISK" rate="129.3"/><Cube currency="NOK" rate="9.4465"/><Cube currency="HRK" rate="7.433"/><Cube currency="RUB" rate="76.1229"/><Cube currency="TRY" rate="6.908"/><Cube currency="AUD" rate="1.607"/><Cube currency="BRL" rate="4.6869"/><Cube currency="CAD" rate="1.4867"/><Cube currency="CNY" rate="7.972"/><Cube currency="HKD" rate="9.0848"/><Cube currency="IDR" rate="17304.55"/><Cube currency="ILS" rate="4.2251"/><Cube currency="INR" rate="84.6215"/><Cube currency="KRW" rate="1290.16"/><Cube currency="MXN" rate="21.5632"/><Cube currency="MYR" rate="4.8049"/><Cube currency="NZD" rate="1.7572"/><Cube currency="PHP" rate="62.733"/><Cube currency="SGD" rate="1.5903"/><Cube currency="THB" rate="37.418"/><Cube currency="ZAR" rate="16.4326"/></Cube>
<Cube time="2018-09-28"><Cube currency="USD" rate="1.1576"/><Cube currency="JPY" rate="131.23"/><Cube currency="BGN" rate="1.9558"/><Cube currency="CZK" rate="25.731"/><Cube currency="DKK" rate="7.4564"/><Cube currency="GBP" rate="0.8873"/><Cube currency="HUF" rate="324.37"/><Cube currency="PLN" rate="4.2774"/><Cube currency="RON" rate="4.6638"/><Cube currency="SEK" rate="10.309"/><Cube currency="CHF" rate="1.1316"/><Cube currency="ISK" rate="128.7"/><Cube currency="NOK" rate="9.4665"/><Cube currency="HRK" rate="7.4346"/><Cube currency="RUB" rate="76.1422"/><Cube currency="TRY" rate="6.965"/><Cube currency="AUD" rate="1.6048"/><Cube currency="BRL" rate="4.6535"/><Cube currency="CAD" rate="1.5064"/><Cube currency="CNY" rate="7.9662"/><Cube currency="HKD" rate="9.0579"/><Cube currency="IDR" rate="17249.98"/><Cube currency="ILS" rate="4.2118"/><Cube currency="INR" rate="83.916"/><Cube currency="KRW" rate="1285.75"/><Cube currency="MXN" rate="21.78"/><Cube currency="MYR" rate="4.789"/><Cube currency="NZD" rate="1.7505"/><Cube currency="PHP" rate="62.648"/><Cube currency="SGD" rate="1.5839"/><Cube currency="THB" rate="37.448"/><Cube currency="ZAR" rate="16.4447"/></Cube>
<Cube time="2018-09-27"><Cube currency="USD" rate="1.1707"/><Cube currency="JPY" rate="132.15"/><Cube currency="BGN" rate="1.9558"/><Cube currency="CZK" rate="25.715"/><Cube currency="DKK" rate="7.4591"/><Cube currency="GBP" rate="0.88973"/><Cube currency="HUF" rate="323.7"/><Cube currency="PLN" rate="4.2779"/><Cube currency="RON" rate="4.6701"/><Cube currency="SEK" rate="10.3208"/><Cube currency="CHF" rate="1.1371"/><Cube currency="ISK" rate="128.7"/><Cube currency="NOK" rate="9.5015"/><Cube currency="HRK" rate="7.4318"/><Cube currency="RUB" rate="76.9011"/><Cube currency="TRY" rate="7.0415"/><Cube currency="AUD" rate="1.62"/><Cube currency="BRL" rate="4.729"/><Cube currency="CAD" rate="1.5301"/><Cube currency="CNY" rate="8.055"/><Cube currency="HKD" rate="9.1478"/><Cube currency="IDR" rate="17450.33"/><Cube currency="ILS" rate="4.2188"/><Cube currency="INR" rate="84.983"/><Cube currency="KRW" rate="1301.82"/><Cube currency="MXN" rate="22.0889"/><Cube currency="MYR" rate="4.8398"/><Cube currency="NZD" rate="1.7638"/><Cube currency="PHP" rate="63.357"/><Cube currency="SGD" rate="1.5976"/><Cube currency="THB" rate="37.96"/><Cube currency="ZAR" rate="16.5152"/></Cube>
</Cube>
</gesmes:Envelope>'

def load_sample_rates
  RATES.each { |r| Rate.create! r }
end
