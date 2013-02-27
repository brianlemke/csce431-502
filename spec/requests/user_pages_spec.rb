require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "signup page" do
    before { visit new_user_path }

    it { should have_selector('input#user_name') }
    it { should have_selector('input#user_email') }
    it { should have_selector('input#user_password') }
    it { should have_selector('input#user_password_confirmation') }
  end

  describe "signup" do
    let(:submit) { "Create my account" }

    before { visit new_user_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.build(:user) }

      before do
        fill_in "Create a Username", with: user.name
        fill_in "Email", with: user.email
        fill_in "Create a password", with: user.password
        fill_in "Confirm your password", with: user.password_confirmation
      end

      it "should create a user" do
        expect { click_button submit}.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }

        it { should have_selector('h1', text: user.email) }
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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }

    describe "without signing in" do
      before { visit edit_user_path(user) }
      it { should have_button("Sign in") }
    end

    describe "as other admin" do
      let(:admin) do
        FactoryGirl.create(:admin, email: "admin@example.com")
      end

      before do
        sign_in admin
        visit edit_user_path(user)
      end

      it { should have_field("Email") }
      it { should have_button("Save") }

      describe "with valid information" do
        let(:new_name) { "username" }
        let(:new_email) { "newemail@example.com" }

        before do
          fill_in "Edit your Username", with: new_name
          fill_in "Email", with: new_email
          fill_in "Password", with: user.password
          fill_in "Confirmation", with: user.password_confirmation
          click_button "Save"
        end

        it { should have_selector('h1', text: new_email) }
        specify { user.reload.email.should == new_email }
      end
    end

    describe "after signing in" do
      before do
        sign_in user
        visit edit_user_path(user)
      end

      it { should have_field("Email") }
      it { should have_button("Save") }

      describe "with invalid information" do
        before { click_button "Save" }

        it { should have_field("Email") }
        it { should have_button("Save") }
      end

      describe "with valid information" do
        let(:new_name) { "username" }
        let(:new_email) { "newemail@example.com" }

        before do
          fill_in "Edit your Username", with: new_name
          fill_in "Email", with: new_email
          fill_in "Password", with: user.password
          fill_in "Confirmation", with: user.password_confirmation
          click_button "Save"
        end

        it { should have_selector('h1', text: new_email) }
        specify { user.reload.email.should == new_email }
      end
    end
  end
end
