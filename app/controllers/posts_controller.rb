class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    find_post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
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
end
