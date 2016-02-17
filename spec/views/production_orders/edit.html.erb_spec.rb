require 'spec_helper'

describe "production_orders/edit" do
  before(:each) do
    @production_order = assign(:production_order, stub_model(ProductionOrder))
  end

  it "renders the edit production_order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", production_order_path(@production_order), "post" do
    end
  end
end
