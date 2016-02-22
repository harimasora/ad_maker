require 'spec_helper'

describe "banners/show" do
  before(:each) do
    @banner = assign(:banner, stub_model(Banner,
      :kind => "Kind",
      :description => "Description",
      :state => "State",
      :keywords => "Keywords",
      :rank => 1,
      :image => "Image",
      :production_order => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Kind/)
    rendered.should match(/Description/)
    rendered.should match(/State/)
    rendered.should match(/Keywords/)
    rendered.should match(/1/)
    rendered.should match(/Image/)
    rendered.should match(//)
  end
end
