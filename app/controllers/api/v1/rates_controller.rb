class Api::V1::RatesController < ApplicationController
  respond_to :json
  
  def index
    rates = Rate.where_date(params[:date])
    respond_with rates.by_currency
  end
end