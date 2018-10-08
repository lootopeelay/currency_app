# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'date'

module RatesHelper
  class << self
    def load_rates_from_file
      filename = File.join Rails.root, "rates.xml"
      puts filename
      doc = File.open(filename) { |f| Nokogiri::XML(f) }
      load_rates_from_xml(doc)
    end

    def load_rates_from_xml(xml)
    	xml.remove_namespaces!
      dates = xml.xpath('//Cube[@time]')

      dates.each do |date|
        rate_date = DateTime.strptime(date['time'], '%Y-%m-%d')
        date.children.each do |rate|
          Rate.create_with(rate: rate['rate']).find_or_create_by(date: rate_date, currency: rate['currency'])
        end
      end
    end
  end
end
