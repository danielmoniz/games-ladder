class MatchesController < ApplicationController
  before_action do |controller|
    @category = Category.find(params[:category_id])
  end

  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @matches = Match.order(created_at: :desc).limit(50)
  end

  def show
    @match = Match.find(params[:id])
  end

  def new
    @match = Match.new
  end

  # @TODO Needs to auto-populate the view with pre-selected teams
  def edit
    @match = Match.find(params[:id])
  end

  # @TODO Needs to act more like create
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
      team = get_existing_team(player_ids)
      if team
        @match.teams << team
        next
      end

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

  private

  def my_require_login

  end

  def get_existing_team(player_ids)
    # is this the most efficient way to do this?
    teams = Team.joins(:players).where(players: {id: player_ids})
    counts = Hash.new(0)
    teams.map { |team| counts[team.id] += 1 }
    team_ids = counts.select { |id, count| count > 1 }.keys
    if team_ids.count > 0
      Team.find(team_ids.first)
    end
  end
end
