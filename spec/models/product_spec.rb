# encoding: utf-8

require 'spec_helper'

describe Product do
  before do
    @product = Product.new(title: "Example Product", description: "yyyy",
                     image_url: "kame.gif")
  end

  subject { @product }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:image_url) }  

  it { should be_valid }

  describe "when title is not present" do
    before { @product.title = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @product.description = " " }
    it { should_not be_valid }
  end

  describe "when title is already taken" do
    before do
      product_with_same_title = @product.dup
      product_with_same_title.save
    end

    it { should_not be_valid }
  end

  describe "when image url is invalid" do
    it "should be invalid" do
      image_urls = %w[kame.doc kame.gif/more kame.gif.more]
      image_urls.each do |invalid_image_url|
        @product.image_url = invalid_image_url
        expect(@product).not_to be_valid
      end
    end
  end

  describe "when image url is valid" do
    it "should be valid" do
      image_urls = %w[kame.gif kame.jpg kame.png KAME.JPG KAME.Jpg
                      http://a.b.c/x/y/z/kame.gif]
      image_urls.each do |valid_image_url|
        @product.image_url = valid_image_url
        expect(@product).to be_valid
      end
    end
  end
end
