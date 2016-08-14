require 'api_constraints'

class Api::V1::AnimalsController < ApplicationController
  respond_to :json

  #Function used when GET request is made to show animal
  def show
    respond_with Animal.find(params[:id])
  end

  #Function used when POST request is made to create new animal
  def create
    animal = Animal.new(animal_params)
    if !animal.name.nil?
      animal.save
      render json: animal, status: 201, location: [:api, animal]
    else
      render json: { errors: animal.errors }, status: 422
    end
  end

  #Function used when PUT/PATCH request is made to update existing animal
  def update
    animal = Animal.find(params[:id])

    if validate_params(animal_params)
      animal.update(animal_params)
      render json: animal, status: 200, location: [:api, animal]
    else
      render json: { errors: animal.errors }, status: 422
    end
  end


  private

  def animal_params
    params.require(:animal).permit(:name, :leg_count, :lifespan, :is_endangered)
  end

  def validate_params( parameters )
    parameters.length > 0
  end

end
