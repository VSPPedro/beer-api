require 'api_version_constraint'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: "/"  do
    namespace :v1, constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :beers, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
