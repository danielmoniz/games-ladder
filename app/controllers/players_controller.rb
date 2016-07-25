class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      redirect_to action: :show, id: @player.id
    else
      redirect_to action: :edit
    end
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to action: :show, id: @player.id
    else
      redirect_to action: :new
    end
  end

  def destroy
    @player = Player.find(params[:id])

    if @player.destroy
      redirect_to action: :index
    else
      redirect_to action: :show, id: @player.id
    end
  end

  def player_params
    params.require(:player).permit(:name, :email, :password, :password_confirmation)
  end
end
