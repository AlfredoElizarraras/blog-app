class CommentsController < ApplicationController
  before_action :require_login, except: [:create]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.author_name = current_user.username
    @comment.author_id = current_user.id
    if @comment.save
      flash.notice = 'Comment Created!'
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy

    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end
