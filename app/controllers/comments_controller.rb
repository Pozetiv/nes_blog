class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :update, :destroy]
  before_action :find_comment, only: [:update, :destroy]
  before_action :authenticate_user!
  before_action :comment_owner


  def create
    @comment = @post.comments.new(comments_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    else
      flash.now[:danger] = 'Opps we are cant not create'
      redirect_to post_path(@post)
    end
  end

  def update
    if @comment.update_attributes(comments_params)
      redirect_to post_path(@post)
    else
      flash.now[:danger] = 'Opps I cant update this comment'
      redirect_to post_path(@post)
  end

  end

  def destroy
   if @comment.destroy
     redirect_to post_path(@post)
   else
     flash.now[:danger] = 'Opps i cant delete this comments'
     redirect_to post_path(@post)
   end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comments_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = @post.comment.find(params[:id])
  end

  def comment_owner
    unless @comment.user_id == current_user.id
      flash.now[:danger] = "Sorry your are not owner"
      redirect_to post_path(@post)
    end
  end
end
