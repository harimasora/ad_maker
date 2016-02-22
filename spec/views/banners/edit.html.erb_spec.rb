require 'spec_helper'

describe "banners/edit" do
  before(:each) do
    @banner = assign(:banner, stub_model(Banner,
      :kind => "MyString",
      :description => "MyString",
      :state => "MyString",
      :keywords => "MyString",
      :rank => 1,
      :image => "MyString",
      :production_order => nil
    ))
  end

  it "renders the edit banner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", banner_path(@banner), "post" do
      assert_select "input#banner_kind[name=?]", "banner[kind]"
      assert_select "input#banner_description[name=?]", "banner[description]"
      assert_select "input#banner_state[name=?]", "banner[state]"
      assert_select "input#banner_keywords[name=?]", "banner[keywords]"
      assert_select "input#banner_rank[name=?]", "banner[rank]"
      assert_select "input#banner_image[name=?]", "banner[image]"
      assert_select "input#banner_production_order[name=?]", "banner[production_order]"
    end
  end
end
