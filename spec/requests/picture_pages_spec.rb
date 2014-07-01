require 'spec_helper'

describe "Picture Pages" do
  subject { page }

  describe "index" do
    #let(:admin) { FactoryGirl.create(:admin) }
    before do
      #sign_in admin
      visit pictures_path
    end

    it { should have_title('All pictures') }
    it { should have_content('All pictures') }

    describe "pagination" do

      before(:all) { 10.times { FactoryGirl.create(:picture) } }
      after(:all)  { Picture.delete_all }

      #it { should have_selector('div.pagination') }

      it "should list each picture" do
        Picture.paginate(page: 1).each do |picture|
          expect(page).to have_selector('h3', text: picture.name)
        end
      end
    end
  end

  describe "picture page" do
    let(:picture) { FactoryGirl.create(:picture) }
    before { visit picture_path(picture) }

#    let(:picture) {
#      post 'pictures', {
#        'picture' => {
#          :comment => 'this is comment',
#          :name => 'test-image.gif',
#          :data => fixture_file_upload("test-image.gif", 'image/gif'),
#        }
#      }
#     }
        
    it { should have_content(picture.name) }
    it { should have_title(picture.name) }
  end
  
  describe "Upload picture" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_picture_path
    end
    before { visit new_picture_path }
    
    it { should have_content("Upload picture") }
    it { should have_title(full_title("Upload picture")) }    
  end

  describe "upload" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
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

  describe "edit" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:picture) { FactoryGirl.create(:picture) }
    before do
      sign_in admin
      visit edit_picture_path(picture)
    end

    describe "page" do
      it { should have_content("Update picture") }
      it { should have_title("Edit picture") }
    end

    describe "with invalid information" do
      let(:blank_comment)  { " " }
      before do
        fill_in "Comment",  with: blank_comment
        click_button "Save changes"
      end
      
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_comment)  { "New comment" }
      before do
        fill_in "Comment",  with: new_comment
        click_button "Save changes"
      end

      it { should have_title(picture.name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(picture.reload.comment).to  eq new_comment }
    end
  end
end
