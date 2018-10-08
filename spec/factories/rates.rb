# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :rate do
    currency 'USD'
    date '31 March 2018'.to_datetime
    rate 1.92
  end
end
