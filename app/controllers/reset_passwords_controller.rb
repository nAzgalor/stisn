class ResetPasswordsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      flash[:success] = "Instructions have been sent to your email.  #{edit_reset_password_url(id: @user.reset_password_token)}"
      redirect_to login_path
    else
      flash[:warning] = "Account with such email doesn't exist"
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    not_authenticated if @user.blank?
  end

  def update
    @user = User::ResetPassword.(params[:user].merge(id: params[:id]))
    if @user.success?
      flash[:success] = 'Successfuly updated!'
      redirect_to login_path
    else
      flash[:warning] = "#{@user['contract.default'].errors.messages}"
      redirect_to edit_reset_password_path(id: params[:id])
    end
  end
end
