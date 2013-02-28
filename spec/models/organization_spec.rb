# == Schema Information
#
# Table name: organizations
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  name            :string(255)
#  description     :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  login_token     :string(255)
#  verified        :boolean
#

require 'spec_helper'

describe Organization do

  before { @organization = FactoryGirl.build(:organization) }

  subject { @organization }

  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:login_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:posters) }
  it { should respond_to(:verified) }

  it { should be_valid }
  it { should_not be_verified }

  describe "when email is not present" do
    before { @organization.email = " " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @organization.password = @organization.password_confirmation = " "
    end

    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @organization.password = "wrong" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @organization.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[test@foo,com organization_at_foo.org example.test@foo.
                   foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @organization.email = invalid_address
        @organization.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[organization@foo.COM A_US-ER@f.b.org frst.lst@foo.jp
                     a+b@baz.cn test@example.com]
      addresses.each do |valid_address|
        @organization.email = valid_address
        @organization.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      FactoryGirl.create(:organization, email: @organization.email.upcase)
    end

    it { should_not be_valid }
  end

  describe "when a user has the same email address" do
    before do
      FactoryGirl.create(:user, email: @organization.email)
    end

    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @organization.save }
    let(:found_org) { Organization.find_by_email(@organization.email) }

    describe "with valid password" do
      it { should == found_org.authenticate(@organization.password) }
    end

    describe "with invalid password" do
      let(:org_for_invalid_password) { found_org.authenticate("invalid") }

      it { should_not == org_for_invalid_password }
      specify { org_for_invalid_password.should be_false }
    end
  end

  describe "after organization is created" do
    before { @organization.save }

    describe "should be able to be saved without a password" do
      before do
        @organization.password = @organization.password_confirmation = ""
      end

      it { should be_valid }
    end

    describe "login token should be created" do
      its(:login_token) { should_not be_nil }
    end

    describe "it should not be verified" do
      it { should_not be_verified }
    end
  end

  describe "after being verified" do
    before do
      @organization.save
      @organization.toggle!(:verified)
    end

    it { should be_verified }
  end

  describe "poster associations" do

    before { @organization.save }
    let!(:first_poster) do
      FactoryGirl.create(:poster, organization: @organization,
                         created_at: 1.day.ago)
    end

    let!(:second_poster) do
      FactoryGirl.create(:poster, organization: @organization,
                         created_at: 1.hour.ago)
    end

    its(:posters) { should == [first_poster, second_poster] }

    it "should destroy the associated posters" do
      posters = @organization.posters.dup
      @organization.destroy
      posters.should_not be_empty
      posters.each do |poster|
        Poster.find_by_id(poster.id).should be_nil
      end
    end
  end
end
