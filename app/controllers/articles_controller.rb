class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show update edit destroy likes_summary]
  before_action :authorize_article, only: %i[edit update destroy]

  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result.includes(:author).page(params[:page])
    @top_commented_article = Article.top_commented.first
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permitted_attributes(Article))
    @article.author = current_user
    if @article.save
      flash[:notice] = 'Your article has been saved'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = @article.comments.build(commenter: session[:commenter])
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

    respond_to do |format|
      format.html do
        @article.increment!(:views_count)
        render
      end
      format.json do
        render json: {
          id: @article.id,
          likes: @article.likes_count,
          comments: @article.comments_count
        }
      end
    end
  end

  def edit; end

  def update
    if @article.update(permitted_attributes(@article))
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

  def likes_summary
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def authorize_article
    authorize @article
  end
end
