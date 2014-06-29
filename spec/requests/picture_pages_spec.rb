require 'spec_helper'

describe "Picture Pages" do
  subject { page }

  describe "picture page" do
    let(:picture) { FactoryGirl.create(:picture) }
    before { visit picture_path(picture) }

    it { should have_content(picture.name) }
    it { should have_title(picture.name) }
  end
  
  describe "Upload picture" do
    #let(:admin) { FactoryGirl.create(:admin) }
    before do
    #  sign_in admin
      visit new_picture_path
    end
    before { visit new_picture_path }
    
    it { should have_content("Upload picture") }
    it { should have_title(full_title("Upload picture")) }    
  end

  describe "upload" do
    #let(:admin) { FactoryGirl.create(:admin) }
    before do
    #  sign_in admin
      visit new_picture_path
    end

    let(:submit) { "Upload file" }

    describe "with invalid information" do
      it "should not create a picture" do
        expect { click_button submit }.not_to change(Picture, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Upload  picture') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Comment",  with: "Example comment"
        attach_file "Uploaded picture", "#{Rails.root}/spec/kame.gif"
      end

      it "should create a picture" do
        expect { click_button submit }.to change(Picture, :count).by(1)
      end

      describe "after saving the picture" do
        before { click_button submit }
        let(:picture) { Picture.find_by(name: 'kame.gif') }

        it { should have_title(picture.name) }
        it { should have_selector('div.alert.alert-success', text: 'sucess!') }
      end
    end
  end
end
