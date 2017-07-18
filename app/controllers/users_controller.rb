class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create activate post_create]
  before_action :set_user, only: %i[edit show]

  def index
    @users = User.all #zaglushka chto bi chto-to pokazivat'
  end

  def new
    @user = User.new
  end

  def create
    @user = User::PreCreate.(params[:user])
    if @user.success?
      flash[:success] = "Welcome!  #{activate_user_url(@user['model'].activation_token)}"
      redirect_to login_path
    else
      render 'new'
    end
  end

  def update
    @user = User::Update.(params[:user].merge(id: params[:id]))
    if @user.success?
      flash[:success] = 'Successfuly updated!'
      redirect_to users_path
    else
      flash[:warning] = "#{@user['contract.default'].errors.messages}"
      redirect_to edit_user_path
    end
  end

  def activate
    @user = User.load_from_activation_token(params[:id])
  end

  def post_create
    @user = User::Activate.new.(params[:user].merge(id: params[:id]))
    if @user.success?
      flash[:success] = 'HERE WE GO BABY!'
      redirect_to login_path
    else
      flash[:warning] = "wtf! #{@user['contract.default'].errors.messages}"
      redirect_to activate_user_url
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
