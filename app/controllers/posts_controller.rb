class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!
  before_action :post_owner, only: [:edit, :update, :destroy]

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
      @comments = @post.comments.all.page params[:page]
      @comment = current_user.comments.new
    end

    def destroy
      if @post.destroy
        redirect_to posts_path, success: 'Post destroy'
      else
        redirect_to posts_path, warning: 'Opps cant destroy this post'
      end
    end

    def add_to_favorite
      @post = Post.friendly.find(params[:post_id])
      redirect_to @post if current_user.favorite(@post)
    end

    private

    def find_post
      @post = Post.friendly.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :image, :short_body, :category_id)
    end

   def post_owner
     unless  @post.user_id == current_user.id
       flash[:info] = "You are not owner"
     end
   end
end
