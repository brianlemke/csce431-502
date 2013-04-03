require'spec_helper'

describe PostersController do

  before do
    @organization = FactoryGirl.create(:organization)
    @poster = FactoryGirl.create(:poster, organization: @organization)
  end

  let(:valid_params) do
    {
      title: "Dummy title",
      file: "dummy.jpg"
    }
  end

  describe "with valid login cookies" do

    before { request.cookies['login_token'] = @organization.login_token }

    describe "GET index" do
      it "assigns all posters as @posters" do
        get :index
        assigns(:posters).should == [@poster]
      end
    end

    describe "GET show" do
      it "assigns the requested poster as @poster" do
        get :show, { id: @poster.to_param }
        assigns(:poster).should == @poster
      end
    end

    describe "GET new" do
      it "assigns a new poster as @poster" do
        get :new
        assigns(:poster).should be_a_new(Poster)
      end
    end

    describe "GET edit" do
      it "assigns the requested poster as @poster" do
        get :edit, { id: @poster.to_param }
        assigns(:poster).should == @poster
      end
    end

    describe "POST create" do
      let(:new_poster) do
        FactoryGirl.build(:poster, organization: @organization)
      end

      describe "with valid params" do
        it "creates a new poster" do
          expect {
            post :create, { poster: valid_params }
          }.to change(Poster, :count).by(1)
        end

        it "assigns a newly created poster as @poster" do
          post :create, { poster: valid_params }
          assigns(:poster).should be_a(Poster)
          assigns(:poster).should be_persisted
        end

        it "assigns the owning organization as @organization" do
          post :create, { poster: valid_params }
          assigns(:organization).should == @organization
        end

        it "redirects to the created poster" do
          post :create, { poster: valid_params }
          response.should redirect_to(Poster.last)
        end
      end

      describe "with invalid params" do
        before do
          Poster.any_instance.stub(:save).and_return(false)
          post :create, { poster: {} }
        end

        it "assigns a newly created but unsaved poster as @poster" do
          assigns(:poster).should be_a_new(Poster)
        end

        it "assigns the owning organization as @organization" do
          assigns(:organization).should == @organization
        end

        it "re-renders the 'new' template" do
          response.should render_template "new"
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do

        it "updates the requested poster" do
          Poster.any_instance.should_receive(:update_attributes).
              with({ 'test' => 'data' })
          put :update, { id: @poster.to_param, poster: { 'test' => 'data' } }
        end

        it "assigns the requested poster as @poster" do
          put :update, { id: @poster.to_param, poster: valid_params }
          assigns(:poster).should eq(@poster)
        end

        it "assigns the owning organization as @organization" do
          put :update, { id: @poster.to_param, poster: valid_params }
          assigns(:organization).should == @organization
        end

        it "redirects to the poster" do
          put :update, { id: @poster.to_param, poster: valid_params }
          response.should redirect_to(@poster)
        end
      end

      describe "with invalid params" do
        before do
          Poster.any_instance.stub(:save).and_return(false)
          put :update, { id: @poster.to_param, poster: {} }
        end

        it "assigns the poster as @poster" do
          assigns(:poster).should == @poster
        end

        it "assigns the owning organization as @organization" do
          assigns(:organization).should == @organization
        end

        it "re-renders the 'edit' template" do
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested poster" do
        expect {
          delete :destroy, { id: @poster.to_param }
        }.to change(Poster, :count).by(-1)
      end

      it "redirects to the posters list" do
        delete :destroy, { id: @poster.to_param }
        response.should redirect_to(posters_url)
      end
    end
  end
end
