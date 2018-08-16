class Api::V1::BeersController < Api::V1::ApplicationController
  def index
    beers = Beer.ransack(params[:q]).result
    render json: Api::V1::BeerSerializer.new(beers).serializable_hash,
           status: :ok
  end

  def show
    beer = Beer.find(params[:id])
    options = {}
    options[:include] = %i[creators tips volumes]
    render json: Api::V1::BeerSerializer.new(beer, options).serializable_hash,
           status: :ok
  end

  def create
    beer = Beer.new(beer_params)

    if beer.save
      render json: Api::V1::BeerSerializer.new(beer).serializable_hash,
             status: :created
    else
      render json: { errors: beer.errors }, status: :unprocessable_entity
    end
  end

  def update
    beer = Beer.find_by(id: params[:id])

    if beer.update_attributes(beer_params)
      render json: Api::V1::BeerSerializer.new(beer).serializable_hash,
             status: :ok
    else
      render json: { errors: beer.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    beer = Beer.find_by(id: params[:id])
    beer.destroy
    head :no_content
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
