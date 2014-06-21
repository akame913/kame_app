# encoding: utf-8

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
  factory :product do
    sequence(:title)  { |n| "Title #{n}" }
    sequence(:description) { |n| "Product_#{n} description"} 
    sequence(:image_url) { |n| "image_#{n}.gif"}
  end    
end
