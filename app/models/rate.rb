# frozen_string_literal: true

class Rate < ApplicationRecord
  def self.where_date(date)
  	converted_date = (date.to_datetime+1).beginning_of_day
	where(date: select('MAX(date)').where('date < ?', converted_date))
  end

  def self.by_currency
    order(:currency)
  end
end
