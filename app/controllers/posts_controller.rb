class PostsController < ApplicationController
  def index
    @posts = Post.all 
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    authorize @post 
    if @post.save
      flash[:notice] = "Bam!"
      redirect_to @post
    else
      flash[:error] = "What was that?! Try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Good stuff!"
      redirect_to @post
    else
      flash[:error] = "Ruh roh! Error! Try again, this time do it right."
      render :edit
  end
end
end
