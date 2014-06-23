# encoding: utf-8

class ProductsController < ApplicationController
  before_action :signed_in_user, only: [:new, :edit, :update, :destroy]
  before_action :admin_user,     only: [:new, :edit, :update, :destroy]
    
  def index
    @products = Product.paginate(page: params[:page], per_page: 10)
  end
  
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

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
       flash[:success] = "Product updated"
       redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product destroyed."
    redirect_to products_url
  end
      
  private

    def product_params
      params.require(:product).permit(:title, :description, :image_url)
    end
end
