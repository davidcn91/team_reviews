class Api::V1::TeamsController < Api::V1::ApiController

  def index
    render json: Team.all
  end

  private

  def review_params
    params.require(:team).permit(:location, :name, :league)
  end


end
