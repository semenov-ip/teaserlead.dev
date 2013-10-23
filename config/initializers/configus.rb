ActionDispatch::Reloader.to_prepare do
  load Rails.root.join('config/configus.rb')
end
