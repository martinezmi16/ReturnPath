require 'spec_helper'

describe Api::V1::AnimalsController do

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


  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @animal_attributes = FactoryGirl.attributes_for :animal
        post :create, { animal: @animal_attributes }, format: :json
      end

      it "renders the json representation for the animal record just created" do
        animal_response = JSON.parse(response.body, symbolize_names: true)
        expect(animal_response[:name]).to eql @animal_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do

        @invalid_animal_attributes = { skill_level: 100 }
        post :create, { animal: @invalid_animal_attributes }, format: :json
      end

      it "renders an errors json" do
        animal_response = JSON.parse(response.body, symbolize_names: true)
        expect(animal_response).to have_key(:errors)
      end

      it "renders the json errors on why the animal could not be created" do
        animal_response = JSON.parse(response.body, symbolize_names: true)
        expect(animal_response[:errors][:name].nil?)
      end

      it { should respond_with 422 }
    end
  end


  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @animal = FactoryGirl.create :animal
        patch :update, { id: @animal.id,
                         animal: { name: "cat" } }, format: :json
      end

      it "renders the json representation for the updated animal" do
        animal_response = JSON.parse(response.body, symbolize_names: true)
        expect(animal_response[:name]).to eql "cat"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @animal = FactoryGirl.create :animal
        patch :update, { id: @animal.id,
                         animal: { skill: "dog" } }, format: :json
      end

      it "renders an errors json" do
        animal_response = JSON.parse(response.body, symbolize_names: true)
        expect(animal_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        animal_response = JSON.parse(response.body, symbolize_names: true)
        expect(animal_response[:errors][:name].nil?)
      end

      it { should respond_with 422 }
    end
  end


  describe "DELETE #destroy" do
    before(:each) do
      @animal = FactoryGirl.create :animal
      delete :destroy, { id: @animal.id }, format: :json
    end

    it { should respond_with 204 }

  end

end
