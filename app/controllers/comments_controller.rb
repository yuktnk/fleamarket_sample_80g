class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/items/#{comment.item.id}"
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
