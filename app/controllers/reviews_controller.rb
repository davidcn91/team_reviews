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

  def edit
    @team = Team.find(params[:team_id])
    @review = Review.find(params[:id])
  end

  def update
    @team = Team.find(params[:team_id])
    @review = Review.find(params[:id])
    if !user_signed_in?
      flash[:notice] = "You must be signed in to update a review."
      redirect_to team_path(@team.id)
    elsif current_user.id != @review.user_id
      flash[:notice] = "You must be the creator of a review to update it."
      redirect_to team_path(@team.id)
    else
      @review.update(review_params)
      if @review.save
        flash[:notice] = "Review updated successfully!"
        redirect_to team_path(@team.id)
      else
        flash[:notice] = "Review length must be 30 characters or greater."
        redirect_to edit_team_review_path(@team.id, @review.id)
      end
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @review = Review.find(params[:id])
    if user_signed_in? && (current_user.id == @review.user_id)
      @review.destroy
      flash[:notice] = "Review deleted successfully."
    end
    redirect_to team_path(@team.id)
  end

  protected

  def review_params
    params.require(:review).permit(:body)
  end

end
