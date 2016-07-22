class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to action: :show, id: @team.id
    else
      redirect_to action: :edit
    end
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to action: :show, id: @team.id
    else
      redirect_to action: :new
    end
  end

  def destroy
    @team = Team.find(params[:id])

    if @team.destroy
      redirect_to action: :index
    else
      redirect_to action: :show, id: @team.id
    end
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
