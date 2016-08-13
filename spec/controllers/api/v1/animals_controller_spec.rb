require 'spec_helper'

describe Api::V1::AnimalsController do
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe "GET #show" do
    before(:each) do
      @animal = FactoryGirl.create :animal
      get :show, id: @animal.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      animal_response = JSON.parse(response.body, symbolize_names: true)
      expect(animal_response[:name]).to eql @animal.name
    end

    it { should respond_with 200 }
  end

end
