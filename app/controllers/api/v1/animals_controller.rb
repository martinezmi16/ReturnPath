require 'api_constraints'

class Api::V1::AnimalsController < ApplicationController
  respond_to :json

  def show
    respond_with Animal.find(params[:id])
  end
end
