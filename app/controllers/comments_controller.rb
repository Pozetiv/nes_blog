class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:update, :edit, :destroy]
  before_action :authenticate_user!
  before_action :comment_owner, only: [:edit, :update, :destroy]



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

  def edit; end

  def update
    if @comment.update(comments_params)
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
     flash.now[:danger] = 'Opps I cant delete this comments'
     redirect_to post_path(@post)
   end
  end

  private

  def find_post
    @post = Post.friendly.find(params[:post_id])
  end

  def comments_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_owner
    unless current_user.id == @comment.user_id
      redirect_to post_path(@post)
      flash[:info] = "Sorry, your are not owner this is comment"
    end
  end


end
