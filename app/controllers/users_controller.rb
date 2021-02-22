class UsersController < ApplicationController
  before_action :set_current_user, :authenticate_user, {only: [:edit, :update, :show]}
  before_action :ensure_current_user, {only: [:edit, :update]}
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to pictures_path
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image, :image_cache)
  end
  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to new_session_path
    end
  end
end
