require 'spec_helper'

describe "Posters" do

  subject { page }

  let(:organization) { FactoryGirl.create(:organization, verified: true) }
  let(:poster) { FactoryGirl.create(:poster, organization: organization) }

  describe "without logging in" do

    describe "new poster page" do
      before { visit new_poster_path }

      it { should_not have_field("Title") }
      it { should_not have_button("Create Poster") }
      it { should have_button("Sign in") }
    end

    describe "edit poster page" do
      before { visit edit_poster_path(poster) }

      it { should_not have_field("Title") }
      it { should_not have_button("Update Poster") }
    end
  end

  describe "after logging in as user" do

    before do
      user = FactoryGirl.create(:user)
      visit new_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    describe "new poster page" do
      before { visit new_poster_path }

      it { should_not have_field("Title") }
      it { should_not have_button("Create Poster") }
    end

    describe "edit poster page" do
      before { visit edit_poster_path(poster) }

      it { should_not have_field("Title") }
      it { should_not have_button("Update Poster") }
    end
  end

  describe "after logging in as admin" do

    before do
      user = FactoryGirl.create(:admin)
      sign_in user
    end

    describe "new poster page" do
      before { visit new_poster_path }

      it { should_not have_field("Title") }
      it { should_not have_button("Create Poster") }
    end

    describe "edit poster page" do
      before { visit edit_poster_path(poster) }

      it { should have_field("Title") }
      it { should have_button("Update Poster") }
    end
  end

  describe "after logging in as organization" do
    before do
      sign_in organization
    end

    describe "new poster page" do
      before { visit new_poster_path }

      it { should have_field("Title") }
      it { should have_button("Create Poster") }
    end

    describe "edit poster page" do
      before { visit edit_poster_path(poster) }

      it { should have_content(poster.file) }
      it { should have_field('Title') }
      it { should have_button('Update Poster') }

      describe "after editing poster" do
        let(:new_title) { "This is a brand new title!" }

        before do
          fill_in "Title", with: new_title
          click_button "Update Poster"
        end

        it { should have_content(new_title) }
        it { should_not have_button("Update Poster") }
      end
    end
  end
end
