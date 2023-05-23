class CommentsController < ApplicationController
  def destroy
    @user = current_user
    @comment = Comment.destroy(params[:id])

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
