# encoding: utf-8

class Product < ActiveRecord::Base
#  before_save { self.image_url = image_url.downcase }
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
#  validates :title, length: {minimum: 10}

end
