class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Commment.new
    authorize @comment
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = comment.find(params[:id])
    authorize @comment
  end

def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comment.build(comment_params)
    @comment.post = @post

    authorize @comment 
    if @comment.save
      redirect_to @post, notice: "Bam!"
    else
      flash[:error] = "What was that?! Try again."
      render :new
    end
  end

  def comment_params
  params.require(:comment).permit(:body)
end

end
