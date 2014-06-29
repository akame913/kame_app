# encoding: utf-8

require 'spec_helper'

describe Picture do
  before do
    @picture = Picture.new(comment: "picture comment", name: "picture_name",
                     data: "this is data", content_type: "image.abc.png" )
  end

  subject { @picture }

  it { should respond_to(:comment) }
  it { should respond_to(:name) }
  it { should respond_to(:data) }  
  it { should respond_to(:content_type) }  
  
  it { should be_valid }

  describe "when comment is not present" do
    before { @picture.comment = " " }
    it { should_not be_valid }
  end

  #describe "when name is not present" do
  #  before { @picture.name = " " }
  #  it { should_not be_valid }
  #end

  #describe "when data is not present" do
  #  before { @picture.data = " " }
  #  it { should_not be_valid }
  #end

  #describe "when content_type is not present" do
  #  before { @picture.content_type = " " }
  #  it { should_not be_valid }
  #end

  #describe "when content_type is not image" do
  #  before { @picture.content_type = "pdf.image" }
  #  it { should_not be_valid }
  #end

  describe "when content_type is invalid" do
    it "should be invalid" do
      content_types = %w[kame.image.doc kameimage.gif/more img.kame.gif.more]
      content_types.each do |invalid_content_type|
        @picture.content_type = invalid_content_type
        expect(@picture).not_to be_valid
      end
    end
  end

  describe "when content_type is valid" do
    it "should be valid" do
      content_types = %w[image.kame.doc image-kame.gif/more imagekame.gif.more]
      content_types.each do |valid_content_type|
        @picture.content_type = valid_content_type
        expect(@picture).to be_valid
      end
    end
  end
end
