FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password '123123'
    password_confirmation '123123'
    roles [:user]
  end

  factory :admin, parent: :user do
    roles [:user, :admin]
  end
end
