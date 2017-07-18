class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def create
    if login(params[:email], params[:password], params[:remember_me])
      flash[:success] = 'Welcome back!'
      redirect_to users_path
    else
      user = User.find_by(email: params[:email])
      if user.present? && user.activation_state == 'pending'
          flash.now[:warning] = 'Your account is not actived'
      else
        flash.now[:warning] = 'E-mail and/or password is incorrect.'
      end
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = 'See you!'
    redirect_to login_path
  end
end
