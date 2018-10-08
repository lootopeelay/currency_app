# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RatesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/rates').to route_to('api/v1/rates#index')
    end

    it 'routes to #new' do
      expect(get: '/api/v1/rates/new').not_to be_routable
    end

    it 'routes to #show' do
      expect(get: '/api/v1/rates/1').not_to be_routable
    end

    it 'routes to #edit' do
      expect(get: '/api/v1/rates/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: '/api/v1/rates').not_to be_routable
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/rates/1').not_to be_routable
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/rates/1').not_to be_routable
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/rates/1').not_to be_routable
    end
  end
end
