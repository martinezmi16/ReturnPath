require 'spec_helper'

describe Api::V1::EmployeesController do

  describe "GET #show" do
    before(:each) do
      @employee = FactoryGirl.create :employee
      get :show, id: @employee.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      employee_response = JSON.parse(response.body, symbolize_names: true)
      expect(employee_response[:first_name]).to eql @employee.first_name
    end

    it { should respond_with 200 }
  end


  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @employee_attributes = FactoryGirl.attributes_for :employee
        post :create, { employee: @employee_attributes }, format: :json
      end

      it "renders the json representation for the employee record just created" do
        employee_response = JSON.parse(response.body, symbolize_names: true)
        expect(employee_response[:first_name]).to eql @employee_attributes[:first_name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do

        @invalid_employee_attributes = { skill_level: 100 }
        post :create, { employee: @invalid_employee_attributes }, format: :json
      end

      it "renders an errors json" do
        employee_response = JSON.parse(response.body, symbolize_names: true)
        expect(employee_response).to have_key(:errors)
      end

      it "renders the json errors on why the employee could not be created" do
        employee_response = JSON.parse(response.body, symbolize_names: true)
        expect(employee_response[:errors][:first_name].nil?)
      end

      it { should respond_with 422 }
    end
  end


  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @employee = FactoryGirl.create :employee
        patch :update, { id: @employee.id,
                         employee: { first_name: "Nancy" } }, format: :json
      end

      it "renders the json representation for the updated employee" do
        employee_response = JSON.parse(response.body, symbolize_names: true)
        expect(employee_response[:first_name]).to eql "Nancy"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @employee = FactoryGirl.create :employee
        patch :update, { id: @employee.id,
                         employee: { skill: "lion tamer" } }, format: :json
      end

      it "renders an errors json" do
        employee_response = JSON.parse(response.body, symbolize_names: true)
        expect(employee_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        employee_response = JSON.parse(response.body, symbolize_names: true)
        expect(employee_response[:errors][:first_name].nil?)
      end

      it { should respond_with 422 }
    end
  end


  describe "DELETE #destroy" do
    before(:each) do
      @employee = FactoryGirl.create :employee
      delete :destroy, { id: @employee.id }, format: :json
    end

    it { should respond_with 204 }

  end

end
