# encoding: utf-8

require 'spec_helper'

describe "Product Pages" do
  subject { page }

  describe "index" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit products_path
    end

    it { should have_title('All products') }
    it { should have_content('All products') }

    describe "pagination" do

      before(:all) { 10.times { FactoryGirl.create(:product) } }
      after(:all)  { Product.delete_all }

      #it { should have_selector('div.pagination') }

      it "should list each product" do
        Product.paginate(page: 1).each do |product|
          expect(page).to have_selector('h3', text: product.title)
        end
      end
    end
  end
    
  describe "product page" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:product) { FactoryGirl.create(:product) }
    before do
      sign_in admin
      visit product_path(product)
    end

    it { should have_content(product.title) }
    it { should have_title(product.title) }
  end
  
  describe "new product" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_product_path
    end
    #before { visit '/products/new' }
    before { visit new_product_path }
    
    it { should have_content("New product") }
    it { should have_title(full_title("New product")) }    
  end

  describe "product form" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_product_path
    end

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

      describe "after saving the product" do
        before { click_button submit }
        let(:product) { Product.find_by(title: 'Example product') }

        it { should have_title(product.title) }
        it { should have_selector('div.alert.alert-success', text: 'sucess!') }
      end
    end
  end

  describe "edit" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:product) { FactoryGirl.create(:product) }
    before do
      sign_in admin
      visit edit_product_path(product)
    end

    describe "page" do
      it { should have_content("Update product") }
      it { should have_title("Edit product") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      #it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_title)  { "New title" }
      let(:new_description) { "New description" }
      let(:new_image_url) { "new_image_url.gif" }
      before do
        fill_in "Title",         with: new_title
        fill_in "Description",   with: new_description
        fill_in "Image url",     with: new_image_url
        click_button "Save changes"
      end

      it { should have_title(new_title) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(product.reload.title).to  eq new_title }
      specify { expect(product.reload.description).to eq new_description }
      specify { expect(product.reload.image_url).to eq new_image_url }
    end
  end
end
