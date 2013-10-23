include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :teaser do
    text "Lorem ipsum — dolor sit amet"
    image { fixture_file_upload('spec/support/test_images/1.jpg', 'image/jpeg') }
  end
end
