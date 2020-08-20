class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      respond_to do |format|
        format.json
      end
    else
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    comment = Comment.find(params[:id])
    unless comment.destroy
      redirect_back(fallback_location: root_path)
    else
      
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end