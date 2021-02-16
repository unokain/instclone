class PicturesController < ApplicationController
    before_action :set_picture, only: [:show, :edit, :update, :destroy]
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
        redirect_to pictures_path
      else
        render :new
      end
    end
  end
  def show
    @picture = Picture.find(params[:id])
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
end
