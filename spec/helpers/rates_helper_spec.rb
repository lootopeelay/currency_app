# frozen_string_literal: true

require 'rails_helper'
require 'nokogiri'

# Specs in this file have access to a helper object that includes
# the RatesHelper. For example:
#
# describe RatesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

RSpec.describe RatesHelper, type: :helper do
	before(:each) do
    Rate.delete_all
  end

  let(:rates_xml) { Nokogiri::XML(XML_RATES) }

  describe 'load_rates_from_xml' do

    it 'adds more than 1 rate' do
      count = Rate.count()
      expect(count).to eq(0)

      RatesHelper.load_rates_from_xml(rates_xml)

      expect(Rate.count()).to be > count
    end

    it 'adds no new rates if there are none' do
      count = Rate.count()
      expect(count).to eq(0)

      RatesHelper.load_rates_from_xml(rates_xml)
      load_count = Rate.count()

      expect(load_count).to be > count

      RatesHelper.load_rates_from_xml(rates_xml)
      expect(load_count).to eq(Rate.count())

    end

  end
end
