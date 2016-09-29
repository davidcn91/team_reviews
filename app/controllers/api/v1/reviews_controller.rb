require 'pry'
class Api::V1::ReviewsController < Api::V1::ApiController

  def index
    render json: Review.all
  end

  def show
    review = Review.find(params[:id])
    render json: review
  end

  def create

  end

  def update
    review = Review.find(params[:id])
    if params[:vote] == "up"
      review.update(vote: (review.vote + 1))
    else
      review.update(vote: (review.vote - 1))
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :user_id, :team_id, :rating)
  end


end
