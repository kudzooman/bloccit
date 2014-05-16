class TopicsController < ApplicationController
  def index
    @topic = Topic.all 
    authorize @topic
  end

  def new
    @topic = Topic.new
    authorize @topic 
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def create
    @topic = Topic.new(params.require(:topic).permit(:name, :description, :public))
    authorize @topic
    if @topic.save
      redirect_to @topic, notice: "Oh yeah, topic saved!"
    else
      flash[:error] = "Whoa, whoa, whoa. What was that? Try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update_attributes(params.require(:topic).permit(:name, :description, :public))
      redirect_to @topic
    else
      flash[:error] = "Nope. ERROR! 'Try' again."
      render :edit
    end

  end
    
end

