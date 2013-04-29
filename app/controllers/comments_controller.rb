class CommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create]
  before_filter :correct_user, only: [:destroy]

  # POST /comments
  # POST /comments.json
  def create
    @poster = Poster.find(params[:poster_id])
    @comment = @poster.comments.build(params[:comment])
    @comment.name = current_account.name
    @comment.save
    redirect_to poster_path(@poster)
  end


  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.poster }
      format.json { head :no_content }
    end
  end

private

  def signed_in_user
    unless current_account.is_a? User
      session[:return_to] = request.url
      redirect_to new_session_url, notice: "Please sign in"
    end
  end

  def correct_user
    unless current_account == User.find_by_id(params[:id])
      redirect_to root_path
    end
  end

end
