class CommentsController < ApplicationController
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
end
