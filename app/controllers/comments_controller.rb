class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to item_path(params[:item_id])  }
      format.json
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], item_id: params[:item_id])
    comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end