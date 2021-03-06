class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:session])

    if @user
      sign_in!(@user)
      redirect_to root_path
    else
      flash.now[:error] = "Invalid username and/or password"
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to root_path
  end

end
