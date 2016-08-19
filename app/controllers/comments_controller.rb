class CommentsController < ApplicationController
  # Uses the magic of Arganath to spawn a comment and save to database
  def create
    @comment = Comment.new(comment_params)
    @comment.list = List.find(params[:list_id])
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.list
    else
      redirect_to @comment.list
    end
  end

  # Sends the comment to the trash can of doom
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to @comment.list
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
