class ArticlesController < ApplicationController
  before_action :require_login, except: %i[index show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @author = Author.find(@article.author_id).username
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @author = Author.find(current_user.id)
    @article = @author.articles.create(article_params)
    if @article.save
      flash.notice = "Article '#{@article.title}' Created!"
      if @article.images.attached?
        @article.images.purge
        @article.images.attach(params[:article][:images])
      end
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    @author = Author.find(current_user.id)
    @article = @author.articles.find(params[:id])
    if @article.update(article_params)
      flash.notice = "Article '#{@article.title}' Successfully Updated!"
      if @article.images.attached?
        @article.images.purge
        @article.images.attach(params[:article][:images])
      end

      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @author = Author.find(current_user.id)
    @article = @author.articles.find(params[:id])
    @article.destroy
    flash.notice = "Article '#{@article.title}' Successsfully deleted"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :tag_list, images: [])
  end
end
