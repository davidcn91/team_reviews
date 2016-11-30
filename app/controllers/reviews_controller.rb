class ReviewsController < ApplicationController

  def new
    @team = Team.find(params[:team_id])
    @review = Review.new
    @rating_collection = Review::RATINGS
  end

  def create
    @team = Team.find(params[:team_id])
    @review = Review.new(review_params)
    @rating_collection = Review::RATINGS
    if !user_signed_in?
      flash[:notice] = "You must be signed in to add a review."
      render :new
    else
      @review.user_id = current_user.id
      @review.team_id = @team.id
      if @review.save
        flash[:notice] = "Review added successfully!"
        User.all.each do |user|
          Vote.create(review_id: @review.id, user_id: user.id)
        end
        # ReviewMailer.review_email(@team.user, @team, @review).deliver
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
    authorize_user(@review)
    @rating_collection = Review::RATINGS
  end

  def update
    @team = Team.find(params[:team_id])
    @review = Review.find(params[:id])
    @rating_collection = Review::RATINGS
    authorize_user(@review)
    @review.update(review_params)
    if @review.save
      flash[:notice] = "Review updated successfully!"
      redirect_to team_path(@team.id)
    else
      flash[:notice] = "Review length must be 30 characters or greater."
      redirect_to edit_team_review_path(@team.id, @review.id)
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @review = Review.find(params[:id])
    authorize_user(@review)
    @review.destroy
    flash[:notice] = "Review deleted successfully."
    redirect_to team_path(@team.id)
  end

  protected

  def review_params
    params.require(:review).permit(:body, :rating)
  end

  def authorize_user(review)
    if !user_signed_in? || (!current_user.admin? && (current_user.id != review.user_id))
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end
