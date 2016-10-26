require 'pry'
class Api::V1::VotesController < Api::V1::ApiController

  def index
    render json: Vote.all
  end

  def show
    vote = Vote.find(params[:id])
    render json: vote
  end

  def create

  end

  def update
    vote = Vote.find(params[:id])
    if params[:vote] == "up"
      vote.update(score: (vote.score + 1))
    else
      vote.update(score: (vote.score - 1))
    end
  end

  private

  def review_params
    params.require(:vote).permit(:body, :user_id, :review_id, :rating, :vote)
  end


end
