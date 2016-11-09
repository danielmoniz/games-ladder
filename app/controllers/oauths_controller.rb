class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    session[:category] = nil
    session[:category] = params[:category]
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    begin
      @user = login_from(provider)
    rescue OAuth2::Error
      go_to_category(nil, alert: "Signup through #{provider.titleize} failed.")
      return
    end
    if @user
      go_to_category(@user, notice: "Logged in from #{provider.titleize}!")
      # redirect_to category_path(nil), :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        if session[:category]
          @user.favourite_category = Category.find(session[:category].to_i)
          session[:category] = nil
        end
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule
        reset_session # protect from session fixation attack
        auto_login(@user)
        go_to_category(@user, notice: "Signed up and logged in from #{provider.titleize}!")
        # redirect_to root_path, :notice => "Signed up and logged in from #{provider.titleize}!"
      rescue ActiveRecord::RecordNotUnique
        # redirect_to root_path, :alert => "Email already exists!"
        go_to_category(@user, alert: "Email already exists!")
      rescue => e
        raise e
        # redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
        go_to_category(@user, alert: "Failed to login from #{provider.titleize}.")
      end
    end
  end

  private
  def auth_params
    params.permit(:code, :provider)
  end

  def go_to_category(user, messages)
    if user and user.favourite_category
      redirect_to category_path(user.favourite_category_id), messages
    elsif session[:category]
      redirect_to category_path(session[:category]), messages
    else
      redirect_to categories_path, messages
    end
  end

end
