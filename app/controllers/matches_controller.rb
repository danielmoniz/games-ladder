class MatchesController < ApplicationController
  before_action do |controller|
    @category = Category.find(params[:category_id])
  end

  def index
    @matches = Match.order(created_at: :desc).limit(50)
  end

  def show
    @match = Match.find(params[:id])
  end

  def new
    @match = Match.new
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update(match_params)
      redirect_to action: :show, id: @match.id
    else
      redirect_to action: :edit
    end
  end

  def create
    @match = Match.new(match_params)
    @match.category = @category
    players = params[:player]

    players.each do |team, player_ids|
      team = Team.new()
      player_ids.each do |id|
        if id == ""; next; end
        team.players << Player.find(id)
      end
      @match.teams << team
    end

    if @match.save
      redirect_to action: :show, id: @match.id
    else
      redirect_to action: :new
    end
  end

  def destroy
    @match = Match.find(params[:id])

    if @match.destroy
      redirect_to action: :index
    else
      redirect_to action: :show, id: @match.id
    end
  end

  def match_params
    params.require(:match).permit(:name, :details, :score, :game_id)
  end
end
