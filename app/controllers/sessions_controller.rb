class SessionsController < ApplicationController
  def new
    @user = Player.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:players, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_back_or_to(root_path, notice: 'Logged out!')
  end
end
