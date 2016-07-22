class MatchesController < ApplicationController
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
    params.require(:match).permit(:name, :status)
  end
end
