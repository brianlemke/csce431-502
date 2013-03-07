class PostersController < ApplicationController
  before_filter :signed_in_organization,
                only: [:new, :create]
  before_filter :correct_organization, only: [:edit, :update, :destroy]

  def index
    @posters = Poster.all
  end

#Eventually use this for main page and when searching
  def mainlist
    if signed_in?
      @allorganizations = Organization.all
      @allposters = Poster.all
      @posters = []
      @organizations = Organization.find(:all, :conditions => ['name LIKE ?', "%#{params[:orgSearch]}%"])
      if params[:dateSearch] != ''
        @organizations.each do |org|
          @posters += org.posters.find(:all, :conditions => ['created_at BETWEEN date(?) AND date(?, "+1 day") AND title LIKE ?', "#{params[:dateSearch]}", "#{params[:dateSearch]}", "%#{params[:titleSearch]}%"])
        end
      elsif params[:orgSearch] != ''
        @organizations.each do |org|
          @posters += org.posters.find(:all, :conditions => ['title LIKE ?', "%#{params[:titleSearch]}%"])
        end
      elsif params[:titleSearch] != ''
        @posters = Poster.find(:all, :conditions => ['title LIKE ?', "%#{params[:titleSearch]}%"])
      else
        @posters = Poster.all
      end
    else
      redirect_to signin_path
    end
  end

  def show
    if signed_in?
      @poster = Poster.find(params[:id])
    else
      redirect_to signin_path
    end
  end

  def new
    @poster = Poster.new
  end

  def edit
  end

  def create
    @poster = @organization.posters.build(params[:poster])

    if @poster.save
      redirect_to @poster, notice: 'Poster was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @poster.update_attributes(params[:poster])
      redirect_to @poster, notice: 'Poster was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @poster.destroy

    redirect_to posters_url
  end

private

  def signed_in_organization
    @organization = current_account
    unless @organization.is_a? Organization
      redirect_to new_session_url, notice: "Please sign in"
    end
  end

  def correct_organization
    @poster = Poster.find_by_id(params[:id])
    unless admin?
      @organization = current_account
      redirect_to root_path unless @poster.organization == @organization
    end
  end
end
