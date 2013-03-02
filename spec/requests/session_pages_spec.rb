require 'spec_helper'

describe "SessionPages" do

  subject { page }

  describe "signin page" do
    before { visit new_session_path }

    it { should have_field('Email') }
    it { should have_field('Password') }
  end

  describe "signin" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit new_session_path }

    describe "with valid information" do
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_selector('h4', text: user.email) }
    end

    describe "with invalid information" do
      let(:wrong_user) { FactoryGirl.build(:user, email: "wrong@example.com") }
      before do
        fill_in "Email", with: wrong_user.email
        fill_in "Password", with: wrong_user.password
        click_button "Sign in"
      end

      it { should have_button('Sign in') }
    end
  end
end
