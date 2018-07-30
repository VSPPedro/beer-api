require 'rails_helper'

RSpec.describe 'Beers API', type: :request do
  before { host! 'api.fractal.test' }

  let!(:beers) { create_list(:beer, 10) }
  let(:beer) { beers.first }
  let(:beer_id) { beer.id }
  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s,
      'Accept' => 'application/api.fractal.v1'
    }
  end

  describe 'GET /beers' do
    before { get '/v1/beers/', params: {}, headers: headers }

    it 'returns beers' do
      expect(json_body).not_to be_empty
      expect(json_body.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /beers/:id' do
    before { get "/v1/beers/#{beer_id}", params: {}, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for beer' do
      expect(json_body[:name]).to eq(beer.name)
    end
  end
end
