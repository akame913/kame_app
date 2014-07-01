# encoding: utf-8

class PicturesController < ApplicationController
  before_action :signed_in_user, only: [:new, :edit, :update, :destroy]
  before_action :admin_user,     only: [:new, :edit, :update, :destroy]
  
  def index
    @pictures = Picture.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      flash[:success] = "Upload picture sucess!"
      redirect_to @picture
    else
      render 'new'
    end
  end

  def download
    @picture = Picture.find(params[:picture_id])
    send_data(@picture.data,
              filename: @picture.name,
              type: @picture.content_type,
              disposition: "inline")
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(picture_params)
       flash[:success] = "Picture updated"
       redirect_to @picture
    else
      render 'edit'
    end
  end

  def destroy
    Picture.find(params[:id]).destroy
    flash[:success] = "Picture destroyed."
    redirect_to pictures_url
  end
        
  private
    # Never trust parameters from the scary internet, only allow the white
    # list through.
    def picture_params
      params.require(:picture).permit(:comment, :uploaded_picture)
    end
end
