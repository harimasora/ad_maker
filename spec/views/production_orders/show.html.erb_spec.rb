require 'spec_helper'

describe "production_orders/show" do
  before(:each) do
    @production_order = assign(:production_order, stub_model(ProductionOrder))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
