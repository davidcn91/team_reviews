class Api::V1::ReviewsController < Api::V1::ApiController

  def index
    render json: Review.all
  end

  def show
    review = Review.find(params[:id])
    render json: review
  end

  private

  def review_params
    params.require(:review).permit(:body, :user_id, :team_id, :rating)
  end


end
