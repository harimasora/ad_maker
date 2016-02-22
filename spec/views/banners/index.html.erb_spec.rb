require 'spec_helper'

describe "banners/index" do
  before(:each) do
    assign(:banners, [
      stub_model(Banner,
        :kind => "Kind",
        :description => "Description",
        :state => "State",
        :keywords => "Keywords",
        :rank => 1,
        :image => "Image",
        :production_order => nil
      ),
      stub_model(Banner,
        :kind => "Kind",
        :description => "Description",
        :state => "State",
        :keywords => "Keywords",
        :rank => 1,
        :image => "Image",
        :production_order => nil
      )
    ])
  end

  it "renders a list of banners" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Keywords".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
