YaAcl::Builder.build do

  roles do # Роли
    role :admin
    role :user
    role :owner
  end

  resources :admin do
  end

end
