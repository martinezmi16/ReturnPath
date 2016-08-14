require 'api_constraints'


ReturnPathApi::Application.routes.draw do

  get 'main/home'

  devise_for :animals

  # Api definition
  namespace :api, defaults: { format: :json },
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :animals, :only => [:show, :create, :update, :destroy]
    end
  end


  devise_for :guests
  # Api definition
  namespace :api, defaults: { format: :json },
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :guests, :only => [:show, :create, :update, :destroy]
    end
  end

  devise_for :employees
  # Api definition
  namespace :api, defaults: { format: :json },
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :employees, :only => [:show, :create, :update, :destroy]
    end
  end

end
