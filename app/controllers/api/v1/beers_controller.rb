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

  def update
    beer = Beer.find_by(id: params[:id])

    if beer.update_attributes(beer_params)
      render json: beer, status: 200
    else
      render json: { errors: beer.errors }, status: 422
    end
  end

  private

  def beer_params
    beer_params = params.require(:beer).permit(:name,
                                               :description,
                                               :fabrication,
                                               creators: %i[id name],
                                               tips: %i[id description],
                                               volumes: %i[id value unit])
    # Making possible that the application accept JSON without the '_attributes'
    # for nested fields. The conditions below are required because these keys
    # are not necessary for a post/put action.
    if beer_params[:tips]
      beer_params[:tips_attributes] = beer_params.delete :tips
    end
    if beer_params[:creators]
      beer_params[:creators_attributes] = beer_params.delete :creators
    end
    if beer_params[:volumes]
      beer_params[:volumes_attributes] = beer_params.delete :volumes
    end
    beer_params.permit!
  end
end
