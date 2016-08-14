require 'spec_helper'

describe ApiController do

  describe "GET 'v1'" do
    it "returns http success" do
      get 'v1'
      response.should be_success
    end
  end

  describe "GET 'guests'" do
    it "returns http success" do
      get 'guests'
      response.should be_success
    end
  end

end
