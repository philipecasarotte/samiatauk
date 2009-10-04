class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if @comment = @post.comments.create!(params[:comment])
      flash.now[:notice] = "Seu comentário foi enviado"
    else
      flash.now[:error] =  "Seu comentário não pode ser enviado"
    end
    respond_to do |format| 
      format.html {redirect_to @post}
      format.js
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash.now[:notice] = "Comentário apagado."
    else
      flash.now[:error] = "Comentário não pode ser apagado."
    end
    redirect_to post_path(Post.find(@comment.post_id).permalink)
  end
end
