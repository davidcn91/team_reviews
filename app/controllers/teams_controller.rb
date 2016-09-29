require 'pry'
class TeamsController < ApplicationController

  def index
    @teams = Team.order(:league).page params[:page]
  end

  def new
    @team = Team.new
    @league_collection = Team::LEAGUES
  end

  def create
    @team = Team.new(team_params)
    @league_collection = Team::LEAGUES
    if !user_signed_in?
      flash[:notice] = "You must be signed in to add a team."
      render :new
    else
      @team.user_id = current_user.id
      if @team.save
        flash[:notice] = "Team added successfully!"
        redirect_to teams_path
      else
        flash[:notice] = "Please fill out all fields."
        render :new
      end
    end
  end

  def show
    @team = Team.find(params[:id])
    @reviews = @team.reviews.order(created_at: :desc).page params[:page]
  end

  def edit
    @team = Team.find(params[:id])
    authorize_user(@team)
    @league_collection = Team::LEAGUES
  end

  def update
    @team = Team.find(params[:id])
    authorize_user(@team)
    @league_collection = Team::LEAGUES
    @team.update(team_params)
    if @team.save
      flash[:notice] = "Team updated successfully!"
      redirect_to team_path(@team.id)
    else
      flash[:notice] = "Please fill out all fields."
      redirect_to edit_team_path(@team.id)
    end
  end

  def destroy
    @team = Team.find(params[:id])
    authorize_user(@team)
    @team.destroy
    flash[:notice] = "Team deleted successfully."
    redirect_to teams_path
  end

  protected
  def team_params
    params.require(:team).permit(
      :location,
      :name,
      :league,
    )
  end

  def authorize_user(team)
    if !user_signed_in? || (!current_user.admin? && (current_user.id != team.user_id))
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
