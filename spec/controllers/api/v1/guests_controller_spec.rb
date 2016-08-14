require 'spec_helper'

describe Api::V1::GuestsController do

  describe "GET #show" do
    before(:each) do
      @guest = FactoryGirl.create :guest
      get :show, id: @guest.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      guest_response = JSON.parse(response.body, symbolize_names: true)
      expect(guest_response[:first_name]).to eql @guest.first_name
    end

    it { should respond_with 200 }
  end


  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @guest_attributes = FactoryGirl.attributes_for :guest
        post :create, { guest: @guest_attributes }, format: :json
      end

      it "renders the json representation for the guest record just created" do
        guest_response = JSON.parse(response.body, symbolize_names: true)
        expect(guest_response[:first_name]).to eql @guest_attributes[:first_name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do

        @invalid_guest_attributes = { skill_level: 100 }
        post :create, { guest: @invalid_guest_attributes }, format: :json
      end

      it "renders an errors json" do
        guest_response = JSON.parse(response.body, symbolize_names: true)
        expect(guest_response).to have_key(:errors)
      end

      it "renders the json errors on why the guest could not be created" do
        guest_response = JSON.parse(response.body, symbolize_names: true)
        expect(guest_response[:errors][:first_name].nil?)
      end

      it { should respond_with 422 }
    end
  end


  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @guest = FactoryGirl.create :guest
        patch :update, { id: @guest.id,
                         guest: { first_name: "Dave" } }, format: :json
      end

      it "renders the json representation for the updated guest" do
        guest_response = JSON.parse(response.body, symbolize_names: true)
        expect(guest_response[:first_name]).to eql "Dave"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @guest = FactoryGirl.create :guest
        patch :update, { id: @guest.id,
                         guest: { skill: "carpenter" } }, format: :json
      end

      it "renders an errors json" do
        guest_response = JSON.parse(response.body, symbolize_names: true)
        expect(guest_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        guest_response = JSON.parse(response.body, symbolize_names: true)
        expect(guest_response[:errors][:first_name].nil?)
      end

      it { should respond_with 422 }
    end
  end


  describe "DELETE #destroy" do
    before(:each) do
      @guest = FactoryGirl.create :guest
      delete :destroy, { id: @guest.id }, format: :json
    end

    it { should respond_with 204 }

  end

end
