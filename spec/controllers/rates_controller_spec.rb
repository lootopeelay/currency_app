# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RatesController, type: :controller do
  render_views

  before do
    load_sample_rates
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RatesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:date_params) { { date: '2018-09-24'.to_datetime } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: date_params, session: valid_session, format: :json
      expect(response).to be_successful
    end

    it 'returns rates for the supplied date' do
      get :index, params: date_params, session: valid_session, format: :json
      expect(response).to be_successful

      dates = decoded_response(response).map { |r| r['date'] }
      expect(dates.length).to be > 1
      expect(dates.uniq.length).to eq(1)
    end
  end
end
