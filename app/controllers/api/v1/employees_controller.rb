require 'api_constraints'

class Api::V1::EmployeesController < ApplicationController
  respond_to :json

  #Function used when GET request is made to show employee
  def show
    respond_with Employee.find(params[:id])
  end

  #Function used when POST request is made to create new employee
  def create
    employee = Employee.new(employee_params)
    if !employee.first_name.nil?
      employee.save
      render json: employee, status: 201, location: [:api, employee]
    else
      render json: { errors: employee.errors }, status: 422
    end
  end

  #Function used when PUT/PATCH request is made to update existing employee
  def update
    employee = Employee.find(params[:id])

    if validate_params(employee_params)
      employee.update(employee_params)
      render json: employee, status: 200, location: [:api, employee]
    else
      render json: { errors: employee.errors }, status: 422
    end
  end


  #Function used when DELETE request is made to remove existing employee
  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    head 204
  end


  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :tenure, :department)
  end

  def validate_params( parameters )
    parameters.length > 0
  end

end
