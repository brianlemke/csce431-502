class PostersController < ApplicationController
  before_filter :signed_in_organization,
                only: [:new, :create]
  before_filter :correct_organization, only: [:edit, :update, :destroy]

  def index
    @posters = Poster.all
  end

#Eventually use this for main page and when searching
  def mainlist
    @organizations = []
    if params.has_key?(:orgSearch) && params[:orgSearch] != ''
      @organizations = Organization.find(:all, :conditions => ['name LIKE ?', "%#{params[:orgSearch]}%"])
    else
      @organizations = Organization.all
    end
    @posters = []
    if params.has_key?(:dateSearch) && params[:dateSearch] != ''
      @organizations.each do |org|
        @posters += org.posters.find(:all, :conditions => ['event_start_date BETWEEN date(?) AND date(?, "+1 day") AND title LIKE ? AND tag LIKE ? AND description LIKE ?', "#{params[:dateSearch]}", "#{params[:dateSearch]}", "%#{params[:titleSearch]}%", "%#{params[:tagSearch]}%", "%#{params[:descriptionSearch]}%"])
      end
    elsif params.has_key?(:orgSearch) && params[:orgSearch] != ''
      @organizations.each do |org|
        @posters += org.posters.find(:all, :conditions => ['title LIKE ? AND tag LIKE ? AND description LIKE ?', "%#{params[:titleSearch]}%", "%#{params[:tagSearch]}%", "%#{params[:descriptionSearch]}%"])
      end
    elsif params.has_key?(:titleSearch) && params[:titleSearch] != ''
      @posters = Poster.find(:all, :conditions => ['title LIKE ? AND tag LIKE ? AND description LIKE ?', "%#{params[:titleSearch]}%", "%#{params[:tagSearch]}%", "%#{params[:descriptionSearch]}%"])
    elsif params.has_key?(:descriptionSearch) && params[:descriptionSearch] != ''
      @posters = Poster.find(:all, :conditions => ['tag LIKE ? AND description LIKE ?', "%#{params[:tagSearch]}%", "%#{params[:descriptionSearch]}%"])
    elsif params.has_key?(:tagSearch) && params[:tagSearch] != ''
      @posters = Poster.find(:all, :conditions => ['tag LIKE ?', "%#{params[:tagSearch]}%"])
    else
      @posters = Poster.all
    end
  end

  def show
    @poster = Poster.find(params[:id])
  end

  def new
    @poster = Poster.new
  end

  def edit
  end

  def create
    @poster = @organization.posters.build(params[:poster])

    if @poster.save
      RegistrationMailer.notify_subscriptions(@poster)
      flash[:success] = "Poster was successfully created"
      redirect_to @poster, notice: 'Poster was successfully created.'
    else
      flash[:error] = "Poster was not created"
      render action: "new"
    end
  end

  def update
    if @poster.update_attributes(params[:poster])
      flash[:success] = "Poster was successfully edited"
      redirect_to @poster, notice: 'Poster was successfully updated.'
    else
      flash[:error] = "Poster was not edited"
      render action: "edit"
    end
  end

  def destroy
    @poster.destroy
    flash[:success] = "Poster successfully destroyed"
    redirect_to posters_url
  end

private

  def signed_in_organization
    @organization = current_account
    unless @organization.is_a? Organization
      flash[:error] = "You are not an organization"
      session[:return_to] = request.url
      redirect_to new_session_url, notice: "Please sign in"
    end
  end

  def correct_organization
    @poster = Poster.find_by_id(params[:id])
    unless admin?
      @organization = current_account
      flash[:error] = "This is not your poster"
      redirect_to root_path unless @poster.organization == @organization
    end
  end
end
