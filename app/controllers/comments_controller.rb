# Comments Controller
class CommentsController < ApplicationController
  before_action :set_article, only: [:create]

  # GET /articles/1/comments/1.json
  def index
    @comments = Comment.where(article_id: params[:article_id]).order(created_at: :desc)
  end

  # POST /articles/1/comments.json
  def create
    @comment = @article.comments.build(comment_params)

    if @comment.save
      render :show, status: :created
    else
      render json: {
        error: @comment.errors.full_messages.join('. ')
      }, status: 400
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  # Whitelisted parameters for Comment.
  def comment_params
    params.require(:comment).permit(:email, :article_id, :title, :content)
  end
end
