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
