class GamesController < ApplicationController
  def index
    @games = Game.all
  end
  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to action: :show, id: @game.id
    else
      redirect_to action: :new
    end
  end

  def destroy
    @game = Game.find(params[:id])

    if @game.destroy
      redirect_to action: :index
    else
      redirect_to action: :show, id: @game.id
    end
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
