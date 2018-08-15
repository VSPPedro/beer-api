require 'rails_helper'

RSpec.describe 'Beers API', type: :request do
  before { host! 'api.fractal.test' }

  let!(:beers) { create_list(:beer_with_creators_and_tips_and_volumes, 3) }
  let(:beer) { beers.first }
  let(:beer_id) { beer.id }
  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s
    }
  end

  describe 'GET /v1/beers' do
    context 'when no param is sent' do
      before { get '/v1/beers/', params: {}, headers: headers }

      it 'returns beers' do
        expect(json_body[:data].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when param is sent' do
      let!(:beer1) { create(:beer, name: 'New b33r 1') }
      let!(:beer2) { create(:beer, name: 'New b33r 2') }

      before { get '/v1/beers?q[name_cont]=b33r', params: {}, headers: headers }

      it 'returns beers' do
        expect(json_body[:data].size).to eq(2)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /v1/beers/:id' do
    before { get "/v1/beers/#{beer_id}", params: {}, headers: headers }

    context 'when there is a beer' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the json with beer name' do
        expect(json_body[:data][:attributes][:name]).to eq(beer.name)
      end

      it 'returns beers creators' do
        expect(json_body[:data][:relationships][:creators]).not_to be_empty
      end

      it 'returns beers tips' do
        expect(json_body[:data][:relationships][:tips]).not_to be_empty
      end

      it 'returns beers volumes' do
        expect(json_body[:data][:relationships][:volumes]).not_to be_empty
      end
    end

    context 'when beer does not exist' do
      let(:beer_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        message = /Couldn't find Beer/
        expect(json_body[:message]).to match(message)
      end
    end
  end

  describe 'POST /v1/beers' do
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
          name: "New #{valid_beer[:name]}", # Making the name unique
          description: valid_beer[:description],
          fabrication: valid_beer[:fabrication],
          creators_attributes: [valid_creator1, valid_creator2],
          tips_attributes: [valid_tip1, valid_tip2],
          volumes_attributes: [valid_volume1, valid_volume2]
        }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the beer in the database' do
        expect(Beer.find_by(name: beer_params[:name])).not_to be_nil
      end

      it 'saves the creators in the database' do
        creators_count = Beer.find_by(name: beer_params[:name]).creators.count
        expect(creators_count).to eq(2)
      end

      it 'saves the tips in the database' do
        tips_count = Beer.find_by(name: beer_params[:name]).tips.count
        expect(tips_count).to eq(2)
      end

      it 'saves the volumes in the database' do
        volumes_count = Beer.find_by(name: beer_params[:name]).volumes.count
        expect(volumes_count).to eq(2)
      end

      it 'returns the json for created beer' do
        expect(json_body[:data][:attributes][:name]).to eq(beer_params[:name])
      end
    end

    context 'when the params are invalid' do
      let(:valid_beer) { attributes_for(:beer) }
      let(:beer_params) do
        {
          name: '', # Invalid name
          description: valid_beer[:description],
          fabrication: valid_beer[:fabrication]
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

  describe 'PUT /v1/beers/:id' do
    let!(:beer) { create(:beer_with_creators_and_tips_and_volumes) }

    before do
      put "/v1/beers/#{beer.id}", params: { beer: beer_params }.to_json,
                                  headers: headers
    end

    context 'when the params are valid' do
      let(:beer_params) { { name: 'New beer name' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json for updated beer' do
        expect(json_body[:data][:attributes][:name]).to eq(beer_params[:name])
      end

      it 'updates the beer in the database' do
        expect(Beer.find_by(name: beer_params[:name])).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:beer_params){ { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json error for name' do
        expect(json_body[:errors]).to have_key(:name)
      end

      it 'does not update the beer in the database' do
        expect(Beer.find_by(name: beer_params[:name])).to be_nil
      end
    end
  end

  describe 'DELETE /v1/beers/:id' do
    let!(:beer) { create(:beer) }

    before do
      delete "/v1/beers/#{beer.id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the beer from the database' do
      expect { Beer.find(beer.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
