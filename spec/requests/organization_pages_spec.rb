require 'spec_helper'

describe "OrganizationPages" do

  subject { page }

  describe "signup page" do 
    before { visit new_organization_path }

    it { should have_selector('input#organization_email') }
    it { should have_selector('input#organization_name') }
    it { should have_selector('textarea#organization_description') }
    it { should have_selector('input#organization_password') }
    it { should have_selector('input#organization_password_confirmation') }
  end

  describe "signup" do
    before { visit new_organization_path }

    let(:submit) { "Request account" }

    describe "with invalid information" do
      it "should not create an organization" do
        expect { click_button submit }.not_to change(Organization, :count)
      end
    end

    describe "with duplicate email" do
      let(:sample_org) { FactoryGirl.create(:organization) }

      before do
        fill_in "Email", with: sample_org.email
        fill_in "Name", with: sample_org.name
        fill_in "Description", with: sample_org.description
        fill_in "Password", with: sample_org.password
        fill_in "Confirmation", with: sample_org.password_confirmation
      end

      it "should not create an organization" do
        expect { click_button submit}.not_to change(Organization, :count)
      end

      it { should have_button submit }
    end

    describe "with valid information" do
      let(:sample_org) { FactoryGirl.build(:organization) }

      before do
        fill_in "Email", with: sample_org.email
        fill_in "Name", with: sample_org.name
        fill_in "Description", with: sample_org.description
        fill_in "Password", with: sample_org.password
        fill_in "Confirmation", with: sample_org.password_confirmation
      end

      it "should create an organization" do
        expect { click_button submit}.to change(Organization, :count).by(1)
      end

      describe "after saving the organization" do
        before { click_button submit }

        it { should have_selector('a', text: 'Sign in') }
        specify { Organization.first.verified.should be_false }
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
    let(:organization) { FactoryGirl.create(:organization) }

    describe "without signing in" do
      before { visit edit_organization_path(organization) }
      it { should have_button("Sign in") }
      it { should_not have_button("Save") }
    end

    describe "as admin" do
      let(:admin) { FactoryGirl.create(:admin) }

      before do
        sign_in admin
        visit edit_organization_path(organization)
      end

      it { should have_field("Email") }
      it { should have_button("Save") }
    end

    describe "without being verified" do
      before do
        sign_in organization
        visit edit_organization_path(organization)
      end

      it { should_not have_button("Save") }
    end

    describe "after being verified" do
      let(:admin) { FactoryGirl.create(:admin) }

      before do
        sign_in admin
        visit edit_organization_path(organization)
        click_button "Verify"
        click_link "Sign out"
      end

      describe "after signing in" do
        before do
          sign_in organization
          visit edit_organization_path(organization)
        end

        it { should have_field("Email") }
        it { should have_button("Save") }

        describe "with invalid information" do
          before do
            fill_in "Email", with: "Bad Email"
            click_button "Save"
          end

          it { should have_field("Email") }
          it { should have_button("Save") }
        end

        describe "with valid information" do
          let(:new_name) { "New Organization Name" }

          before do
            fill_in "Email", with: organization.email
            fill_in "Name", with: new_name
            fill_in "Description", with: organization.description
            fill_in "Password", with: organization.password
            fill_in "Confirmation", with: organization.password_confirmation
            click_button "Save"
          end

          it { should have_selector('h1', text: new_name) }
          specify { organization.reload.name.should == new_name }
        end
      end
    end
  end

  describe "show" do
    let(:organization) { FactoryGirl.create(:organization) }

    describe "without logging in" do
      before { visit organization_path(organization) }

      it { should have_content(organization.name) }
      it { should_not have_button("Subscribe") }
    end

    describe "as user" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
        visit organization_path(organization)
      end

      it { should have_content(organization.name) }
      it { should have_button("Subscribe") }

      describe "after subscribing" do
        before { click_button "Subscribe" }

        it { should have_button("Unsubscribe") }
        specify { user.subscriptions.first.organization.should == organization }

        describe "after unsubscribing" do
          before { click_button "Unsubscribe" }

          it { should have_button("Subscribe") }
          specify { user.subscriptions.empty?.should == true }
        end
      end
    end

    describe "as organization" do

      before do
        sign_in organization
        visit organization_path(organization)
      end

      it { should have_content(organization.name) }
      it { should_not have_button("Subscribe") }
    end
  end
end
