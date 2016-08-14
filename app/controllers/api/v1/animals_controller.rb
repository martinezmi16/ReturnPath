require 'api_constraints'

class Api::V1::AnimalsController < ApplicationController
  respond_to :json

  def show
    respond_with Animal.find(params[:id])
  end

  def create
    animal = Animal.new(animal_params)
    if !animal.name.nil?
      animal.save
      render json: animal, status: 201, location: [:api, animal]
    else
      render json: { errors: animal.errors }, status: 422
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :leg_count, :lifespan, :is_endangered)
  end

end
