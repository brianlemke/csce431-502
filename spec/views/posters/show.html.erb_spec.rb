require 'spec_helper'

describe "posters/show" do
  before(:each) do
    @poster = assign(:poster, stub_model(Poster,
      :file => "File",
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end
end
