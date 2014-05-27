class CommentsController < ApplicationController
  respond_to :html, :js

def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment 

    if @comment.save
      flash[:notice] = "Bam!"
      redirect_to [@topic, @post]
    else
      flash[:error] = "What was that?! Try again."
      render :new
#      redirect_to [@topic, @post, @comments]
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])

    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment go bye bye."
    else
      flash[:error] = "That didn't work. Do again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end

  end

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
