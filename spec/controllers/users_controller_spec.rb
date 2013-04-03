require 'spec_helper'

describe UsersController do

  before do
    @user = FactoryGirl.create(:user)
  end

  let(:valid_params) do
    {
      name: "DummyName",
      email: "different_email@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    }
  end

  describe "with valid login cookies" do

    before { request.cookies['login_token'] = @user.login_token }

    describe "GET show" do
      it "assigns the requested user as @user" do
        get :show, { id: @user.to_param }
        assigns(:user).should == @user
      end
    end

    describe "GET new" do
      it "assigns a new user as @user" do
        get :new
        assigns(:user).should be_a_new(User)
      end
    end

    describe "GET edit" do
      it "assigns the requested user as @user" do
        get :edit, { id: @user.to_param }
        assigns(:user).should == @user
      end
    end

    describe "POST create" do
      let(:new_user) do
        FactoryGirl.build(:user)
      end

      describe "with valid params" do
        it "creates a new user" do
          expect {
            post :create, { user: valid_params }
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          post :create, { user: valid_params }
          assigns(:user).should be_a(User)
          assigns(:user).should be_persisted
        end

        it "redirects to the created user" do
          post :create, { user: valid_params }
          response.should redirect_to(User.last)
        end

        it "should not be admin" do
          post :create, { user: valid_params }
          User.last.should_not be_admin
        end
      end

      describe "with invalid params" do
        before do
          User.any_instance.stub(:save).and_return(false)
          post :create, { user: {} }
        end

        it "assigns a newly created but unsaved user as @user" do
          assigns(:user).should be_a_new(User)
        end

        it "re-renders the 'new' template" do
          response.should render_template "new"
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
  
        it "updates the requested user" do
          User.any_instance.should_receive(:update_attributes).
            with({ 'test' => 'data' })
          put :update, { id: @user.to_param, user: { 'test' => 'data' } }
        end

        it "assigns the requested user as @user" do
          put :update, { id: @user.to_param, user: valid_params }
          assigns(:user).should == @user
        end

        it "redirects to the user" do
          put :update, { id: @user.to_param, user: valid_params }
          response.should redirect_to(@user)
        end
      end

      describe "with invalid params" do
        before do
          User.any_instance.stub(:save).and_return(false)
          put :update, { id: @user.to_param, user: {} }
        end

        it "assigns the requested user as @user" do
          assigns(:user).should == @user
        end

        it "re-renders the 'edit' template" do
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested user" do
        expect {
          delete :destroy, { id: @user.to_param }
        }.to change(User, :count).by(-1)
      end

      it "redirects to the root path" do
        delete :destroy, { id: @user.to_param }
        response.should redirect_to(root_path)
      end
    end
  end
end
