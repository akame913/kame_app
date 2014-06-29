# encoding: utf-8

class PicturesController < ApplicationController


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

  def show
    @picture = Picture.find(params[:id])
  end

  def download
    @picture = Picture.find(params[:picture_id])
    send_data(@picture.data,
              filename: @picture.name,
              type: @picture.content_type,
              disposition: "inline")
  end

  private
    # Never trust parameters from the scary internet, only allow the white
    # list through.
    def picture_params
      params.require(:picture).permit(:comment, :uploaded_picture)
    end
end
