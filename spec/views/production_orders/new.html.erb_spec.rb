require 'spec_helper'

describe "production_orders/new" do
  before(:each) do
    assign(:production_order, stub_model(ProductionOrder).as_new_record)
  end

  it "renders new production_order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", production_orders_path, "post" do
    end
  end
end
