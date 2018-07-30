class Api::V1::BeersController < Api::V1::ApplicationController
  def index
    beers = Beer.all
    render json: beers, status: 200
  end

  def show
    beer = Beer.find(params[:id])
    render json: beer, status: 200
  end

  def create
    beer = Beer.new(beer_params)

    if beer.save
      render json: beer, status: 201
    else
      render json: { errors: beer.errors }, status: 422
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name,
                                 :description,
                                 :fabrication,
                                 creators_attributes: %i[id name],
                                 tips_attributes: %i[id description],
                                 volumes_attributes: %i[id value unit])
  end
end
