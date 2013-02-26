require 'spec_helper'

describe OrganizationsController do

  before do
    @organization = FactoryGirl.create(:organization)
  end

  let(:valid_params) do
    {
      name: "DummyName",
      email: "different_email@example.com",
      description: "This is a dummy description",
      password: "foobar",
      password_confirmation: "foobar"
    }
  end

  describe "with valid login cookies" do

    before { request.cookies['login_token'] = @organization.login_token }

    describe "GET show" do
      it "assigns the requested organization as @organization" do
        get :show, { id: @organization.to_param }
        assigns(:organization).should == @organization
      end
    end

    describe "GET new" do
      it "assigns a new organization as @organization" do
        get :new
        assigns(:organization).should be_a_new(Organization)
      end
    end

    describe "GET edit" do
      it "assigns the requested organization as @organization" do
        get :edit, { id: @organization.to_param }
        assigns(:organization).should == @organization
      end
    end

    describe "POST create" do
      let(:new_organization) do
        FactoryGirl.build(:organization)
      end

      describe "with valid params" do
        it "creates a new organization" do
          expect {
            post :create, { organization: valid_params }
          }.to change(Organization, :count).by(1)
        end

        it "assigns a newly created organization as @organization" do
          post :create, { organization: valid_params }
          assigns(:organization).should be_a(Organization)
          assigns(:organization).should be_persisted
        end

        it "redirects to the created organization" do
          post :create, { organization: valid_params }
          response.should redirect_to(Organization.last)
        end
      end

      describe "with invalid params" do
        before do
          Organization.any_instance.stub(:save).and_return(false)
          post :create, { organization: {} }
        end

        it "assigns a newly created but unsaved organization as @organization" do
          assigns(:organization).should be_a_new(Organization)
        end

        it "re-renders the 'new' template" do
          response.should render_template "new"
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
  
        it "updates the requested organization" do
          Organization.any_instance.should_receive(:update_attributes).
            with({ 'test' => 'data' })
          put :update, { id: @organization.to_param, organization: { 'test' => 'data' } }
        end

        it "assigns the requested organization as @organization" do
          put :update, { id: @organization.to_param, organization: valid_params }
          assigns(:organization).should == @organization
        end

        it "redirects to the organization" do
          put :update, { id: @organization.to_param, organization: valid_params }
          response.should redirect_to(@organization)
        end
      end

      describe "with invalid params" do
        before do
          Organization.any_instance.stub(:save).and_return(false)
          put :update, { id: @organization.to_param, organization: {} }
        end

        it "assigns the requested organization as @organization" do
          assigns(:organization).should == @organization
        end

        it "re-renders the 'edit' template" do
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested organization" do
        expect {
          delete :destroy, { id: @organization.to_param }
        }.to change(Organization, :count).by(-1)
      end

      it "redirects to the root path" do
        delete :destroy, { id: @organization.to_param }
        response.should redirect_to(root_path)
      end
    end
  end
end
