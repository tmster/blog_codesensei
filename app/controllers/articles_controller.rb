class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :update, :edit, :destroy]

  def index
    @articles = Article.all
    if params[:q].present?
      @articles = @articles.where("? = any(tags)", params[:q].downcase)
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = 'Your article has been saved'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = @article.comments.build(commenter: session[:commenter])
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Your article has been saved'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = 'Your article has been deleted'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, )
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
