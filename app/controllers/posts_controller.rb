class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :owned_post, only: [:edit, :update, :destroy]


  def index
    @posts = Post.all
  end

  def show
    find_post
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to @post
    else
      flash[:alert] = "Halt, you fiend! you need an image to post here."
      render :new
    end
  end

  def edit
    find_post
  end

  def update
    find_post
    @post.assign_attributes(post_params)
    if @post.save
      flash[:success] = "Post updated."
      redirect_to @post
    else
      flash[:alert] = "Error updating."
      render :edit
    end
  end

  def destroy
    find_post
    if @post.destroy
      flash[:notice] = "Post deleted."
      redirect_to '/'
    else
      flash[:alert] = "Error deleting."
      render :show
    end
  end


  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def owned_post
    find_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
end
