class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:info] = "Create new post"
      redirect_to @post
    else
      render 'new'
    end
  end

    def edit; end

    def update
      if @post.update_attributes(post_params)
        redirect_to @post, success: 'Update success'
      else
        render 'edit', warning: 'Oppss cant update this post'
      end
    end

    def show
      @comments = @post.comments.all
      @comment = current_user.comments.new
    end

    def destroy
      if @post.destroy
        redirect_to :index, success: 'Post destroy'
      else
        redirect_to :index, warning: 'Opps cant destroy this post'
      end
    end

    private

    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
