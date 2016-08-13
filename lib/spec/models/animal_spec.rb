require 'spec_helper'


describe Animal do
  before { @animal = FactoryGirl.build(:animal) }

  subject { @animal }

  it { should respond_to(:name) }
  it { should respond_to(:leg_count) }
  it { should respond_to(:lifespan) }
  it { should respond_to (:is_endangered)}

end
