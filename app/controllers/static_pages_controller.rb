# encoding: utf-8

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
  
  def contact
  end

  def news
    @user = User.first
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end
end
