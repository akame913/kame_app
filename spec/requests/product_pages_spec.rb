# encoding: utf-8

require 'spec_helper'

describe "Product Pages" do
  subject { page }

  describe "new product" do
    before { visit '/products/new' }
    #before { visit products_path }
    
    it { should have_content("New product") }
    it { should have_title(full_title("New product")) }    
  end
end
