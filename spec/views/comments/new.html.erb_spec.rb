require 'spec_helper'

describe "comments/new" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :name => "MyString",
      :email => "MyString",
      :body => "MyText",
      :poster => nil
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comments_path, :method => "post" do
      assert_select "input#comment_name", :name => "comment[name]"
      assert_select "input#comment_email", :name => "comment[email]"
      assert_select "textarea#comment_body", :name => "comment[body]"
      assert_select "input#comment_poster", :name => "comment[poster]"
    end
  end
end
