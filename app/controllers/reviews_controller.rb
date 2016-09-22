require 'pry'
class ReviewsController < ApplicationController

  def index
  end

  def new
    @team = Team.find(params[:team_id])
    @review = Review.new
  end

  def create
    @team = Team.find(params[:team_id])
    @review = Review.new(review_params)
    if !user_signed_in?
      flash[:notice] = "You must be signed in to add a review."
      render :new
    else
      @review.user_id = current_user.id
      @review.team_id = @team.id
      if @review.save
        flash[:notice] = "Review added successfully!"
        redirect_to team_path(@team.id)
      else
        flash[:notice] = "Review length must be 30 characters or greater."
        render :new
      end
    end
  end

  protected

  def review_params
    params.require(:review).permit(:body)
  end

end
