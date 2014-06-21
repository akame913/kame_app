# encoding: utf-8

require 'spec_helper'

describe "Product Pages" do
  subject { page }

  describe "profile page" do
    let(:product) { FactoryGirl.create(:product) }
    before { visit product_path(product) }

    it { should have_content(product.title) }
    it { should have_title(product.title) }
  end
  
  describe "new product" do
    #before { visit '/products/new' }
    before { visit new_product_path }
    
    it { should have_content("New product") }
    it { should have_title(full_title("New product")) }    
  end

  describe "product form" do

    before { visit new_product_path }

    let(:submit) { "Create Product" }

    describe "with invalid information" do
      it "should not create a product" do
        expect { click_button submit }.not_to change(Product, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('New product') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Title",         with: "Example product"
        fill_in "Description",   with: "foobar"
        fill_in "Image url",     with: "kame.gif"
      end

      it "should create a product" do
        expect { click_button submit }.to change(Product, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:product) { Product.find_by(title: 'Example product') }

        #it { should have_link('Sign out') }
        it { should have_title(product.title) }
        it { should have_selector('div.alert.alert-success', text: 'sucess!') }
      end
    end
  end
end
