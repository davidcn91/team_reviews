require 'pry'
class TeamsController < ApplicationController

  def index
    @teams = Team.all
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
    @reviews = @team.reviews
  end

  def edit
    @team = Team.find(params[:id])
    @league_collection = Team::LEAGUES
  end

  def update
    @team = Team.find(params[:id])
    @league_collection = Team::LEAGUES
    if !user_signed_in?
      flash[:notice] = "You must be signed in to update a team."
      redirect_to edit_team_path(@team.id)
    elsif current_user.id != @team.user_id
      flash[:notice] = "You must be the creator of a team to update it."
      redirect_to edit_team_path(@team.id)
    else
      @team.update(team_params)
      if @team.save
        flash[:notice] = "Team updated successfully!"
        redirect_to team_path(@team.id)
      else
        flash[:notice] = "Please fill out all fields."
        redirect_to edit_team_path(@team.id)
      end
    end
  end

  def destroy
    team = Team.find(params[:id])
    if user_signed_in? && (current_user.id == team.user_id)
      team.destroy
    end
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

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
