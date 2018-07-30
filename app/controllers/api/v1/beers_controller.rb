class Api::V1::BeersController < Api::V1::ApplicationController
  # GET /beers
  def index
    beers = Beer.all
    render json: beers, status: 200
  end

  # GET /beers/:id
  def show
    beer = Beer.find(params[:id])
    render json: beer, status: 200
  end
end
