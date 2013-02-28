require 'spec_helper'

describe "posters/edit" do
  before(:each) do
    @poster = assign(:poster, stub_model(Poster,
      :file => "MyString",
      :title => "MyString"
    ))
  end

  it "renders the edit poster form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posters_path(@poster), :method => "post" do
      assert_select "input#poster_file", :name => "poster[file]"
      assert_select "input#poster_title", :name => "poster[title]"
    end
  end
end
