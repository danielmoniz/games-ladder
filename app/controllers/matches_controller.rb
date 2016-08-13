class MatchesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update]
  before_action do |controller|
    @category = Category.find(params[:category_id])
  end

  def index
    @matches = Match.order(created_at: :desc).limit(75)
  end

  def show
    @match = Match.find(params[:id])
  end

  def new
    @match = Match.new
    @game_id = params[:game_id]
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
    teams = params[:team]
    teams_map = teams.map { |key, id| [key, id] }
    teams_map = teams_map.to_h
    puts teams_map

    players.each do |team_number, player_ids|
      team_number = team_number
      puts team_number
      if teams[team_number] != ''
        team = Team.find(teams[team_number].to_i)
        @match.teams << team
        teams_map[team_number] = team
        next
      end

      team = get_existing_team(player_ids)
      if team
        @match.teams << team
        teams_map[team_number] = team
        next
      end

      team = Team.new();
      player_ids.each do |id|
        if id == ""; next; end
        team.players << Player.find(id)
      end

      if team.players.count > 0
        @match.teams << team
        teams_map[team_number] = team
      end
    end

    winner = params[:winner]
    if winner and winner != ""
      result = MatchResult.create(
        match: @match,
        winner: teams_map[winner.to_i],
      )
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
