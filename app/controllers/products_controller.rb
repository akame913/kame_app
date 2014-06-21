# encoding: utf-8

class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "New product sucess!"
      redirect_to @product
    else
      render 'new'
    end
  end

  private

    def product_params
      params.require(:product).permit(:title, :description, :image_url)
    end
end
