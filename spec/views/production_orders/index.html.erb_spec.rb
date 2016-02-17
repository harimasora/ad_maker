require 'spec_helper'

describe "production_orders/index" do
  before(:each) do
    assign(:production_orders, [
      stub_model(ProductionOrder),
      stub_model(ProductionOrder)
    ])
  end

  it "renders a list of production_orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
