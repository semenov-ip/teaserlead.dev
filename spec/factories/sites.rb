# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    category nil
    title "MyString"
    url "MyString"
    description "MyText"
  end
end
