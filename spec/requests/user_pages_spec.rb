require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "signup page" do
    before { visit new_user_path }

    it { should have_selector('input#user_email') }
    it { should have_selector('input#user_password') }
    it { should have_selector('input#user_password_confirmation') }
  end

  describe "signup" do
    before { visit new_user_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      let(:sample_email) { "test@example.com" }

      before do
        fill_in "Email", with: sample_email
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }

        it { should have_selector('h1', text: sample_email) }
      end
    end

    describe "after invalid signup" do
      let(:bad_email) { "Bad Email" }
      before { fill_in "Email", with: bad_email }

      it "should have email prefilled" do
        find_field("Email").value.should == bad_email
      end
    end
  end
end
