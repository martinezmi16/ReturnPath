require 'api_constraints'

class Api::V1::GuestsController < ApplicationController
  respond_to :json

  #Function used when GET request is made to show animal
  def show
    respond_with Guest.find(params[:id])
  end

  #Function used when POST request is made to create new animal
  def create
    guest = Guest.new(guest_params)
    if !guest.first_name.nil?
      guest.save
      render json: guest, status: 201, location: [:api, guest]
    else
      render json: { errors: guest.errors }, status: 422
    end
  end

  #Function used when PUT/PATCH request is made to update existing animal
  def update
    guest = Guest.find(params[:id])

    if validate_params(guest_params)
      guest.update(guest_params)
      render json: guest, status: 200, location: [:api, guest]
    else
      render json: { errors: guest.errors }, status: 422
    end
  end


  #Function used when DELETE request is made to remove existing animal
  def destroy
    guest = Guest.find(params[:id])
    guest.destroy
    head 204
  end


  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :age, :zoo_member)
  end

  def validate_params( parameters )
    parameters.length > 0
  end

end
