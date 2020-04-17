class CommentsController < ApplicationController
  before_action :require_login, except: [:create]

  def create
    puts params
    # @author = Author.find(current_user.id)
    # @article = @author.articles.find(params[:article_id])
    # @comment = @article.comments.create(comment_params)
    # redirect_to article_path(@article)
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
