class PicturesController < ApplicationController
    before_action :set_current_user, :authenticate_user
    before_action :set_picture, only: [:show, :edit, :update, :destroy]
    before_action :ensure_current_user_picture, {only: [:edit, :update, :destroy]}
  def index
    @pictures = Picture.all 
  end
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @picture.save
        @user=User.find(@picture.user_id)
        ContactMailer.contact_mail(@picture,@user).deliver
        redirect_to pictures_path
      else
        render :new
      end
    end
  end
  def show
    @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end
  def edit
    @picture = Picture.find(params[:id])
  end
  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path
    else
      render :edit
    end
  end
  def destroy
    @picture.destroy
    redirect_to pictures_path
  end
  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end
  private
  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end
  def set_picture
   @picture = Picture.find(params[:id])
  end
  def ensure_current_user_picture
    if current_user.id != @picture.user_id
      flash[:notice]="権限がありません"
      redirect_to new_session_path
    end
  end
end
