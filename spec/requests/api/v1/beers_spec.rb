require 'rails_helper'

RSpec.describe 'Beers API', type: :request do
  before { host! 'api.fractal.test' }

  let!(:beers) { create_list(:beer_with_creators_and_tips_and_volumes, 10) }
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

    it 'returns beers creators' do
      expect(json_body[0][:creators]).not_to be_empty
    end

    it 'returns beers tips' do
      expect(json_body[0][:tips]).not_to be_empty
    end

    it 'returns beers volumes' do
      expect(json_body[0][:volumes]).not_to be_empty
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

  describe 'POST /beers' do
    before do
      post '/v1/beers', params: { beer: beer_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:valid_beer) { attributes_for(:beer) }
      let(:valid_creator1) { attributes_for(:creator) }
      let(:valid_creator2) { attributes_for(:creator) }
      let(:valid_tip1) { attributes_for(:tip) }
      let(:valid_tip2) { attributes_for(:tip) }
      let(:valid_volume1) { attributes_for(:volume) }
      let(:valid_volume2) { attributes_for(:volume) }
      let(:beer_params) do
        {
          name: valid_beer[:name],
          description: valid_beer[:description],
          fabrication: valid_beer[:fabrication],
          creators: [valid_creator1, valid_creator2],
          tips: [valid_tip1, valid_tip2],
          volumes: [valid_volume1, valid_volume2]
        }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'saves the beer in the database' do
        expect(Beer.find_by(name: beer_params[:name])).not_to be_nil
      end

      it 'returns the json for created beer' do
        expect(json_body[:name]).to eq(beer_params[:name])
      end
    end

    context 'when the params are invalid' do
      let(:valid_beer) { attributes_for(:beer) }
      let(:valid_creator1) { attributes_for(:creator) }
      let(:valid_creator2) { attributes_for(:creator) }
      let(:valid_tip1) { attributes_for(:tip) }
      let(:valid_tip2) { attributes_for(:tip) }
      let(:valid_volume1) { attributes_for(:volume) }
      let(:valid_volume2) { attributes_for(:volume) }
      let(:beer_params) do
        {
          name: '', # Invalid name
          description: valid_beer[:description],
          fabrication: valid_beer[:fabrication],
          creators: [valid_creator1, valid_creator2],
          volumes: [valid_volume1, valid_volume2]
        }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'does not save the beer in the database' do
        expect(Beer.find_by(name: beer_params[:name])).to be_nil
      end

      it 'returns the json error for title' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end
end
