# _your_login_ - Поменять на ваш логин в панели управления
# _your_project_ - Поменять на имя вашего проекта
# _your_server_ - Поменять на имя вашего сервера (Указано на вкладке "FTP и SSH" вашей панели управления)
# set :repository - Установить расположение вашего репозитория
# У вас должна быть настроена авторизация ssh по сертификатам


ssh_options[:forward_agent] = true

# Имя вашего проекта в панели управления.
# Не меняйте это значение без необходимости, оно используется дальше.
set :application,     "teaserlead"

# Сервер размещения проекта.
set :deploy_server,   "lithium.locum.ru"

# Не включать в поставку разработческие инструменты и пакеты тестирования.
set :bundle_without,  [:development, :test]

set :user,            "hosting_kinley"
set :login,           "kinley"
set :use_sudo,        false
set :deploy_to,       "/home/#{user}/projects/#{application}"
set :unicorn_conf,    "/etc/unicorn/#{application}.#{login}.rb"
set :unicorn_pid,     "/var/run/unicorn/#{application}.#{login}.pid"
set :bundle_dir,      File.join(fetch(:shared_path), 'gems')
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, :primary => true

# Следующие строки необходимы, т.к. ваш проект использует rvm.
set :rvm_ruby_string, "2.0.0"
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake"
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"
# Настройка системы контроля версий и репозитария,
# по умолчанию - git, если используется иная система версий,
# нужно изменить значение scm.
set :scm,             :git

# Предполагается, что вы размещаете репозиторий Git в вашем
# домашнем каталоге в подкаталоге git/<имя проекта>.git.
# Подробнее о создании репозитория читайте в нашем блоге
# http://locum.ru/blog/hosting/git-on-locum
# set :repository,      "ssh://#{user}@#{deploy_server}/home/#{user}/git/#{application}.git"
set :repository, "ssh://git@bitbucket.org/tuykin/teaserlead.git"

after "deploy:update_code", :remove_rvm_files#, :copy_database_config, :link_public#, :bundle_install, :precompile_assets#, "deploy:start"
after "deploy", "deploy:cleanup"

task :copy_database_config, roles => :app do
  db_config = "#{shared_path}/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

task :link_public, roles => :app do
  run "rm -rf #{release_path}/public"
  run "ln -s #{shared_path}/public #{release_path}/public"
end

task :remove_rvm_files, roles => :app do
  run "rm #{release_path}/.ruby-version"
  run "rm #{release_path}/.ruby-gemset"
end

task :remove_dev_unicorn_config, roles => :app do
  run "rm -f #{release_path}/config/unicorn.rb"
  run "rm -rf #{release_path}/tmp"
end

task :bundle_install do
  run "cd #{release_path}; #{bundle_cmd} install --path #{shared_path}/gems"
end

task :precompile_assets do
  run "cd #{release_path}; #{rake} assets:clean"
  run "cd #{release_path}; #{rake} assets:precompile"
end

set :unicorn_rails, "/var/lib/gems/#{rvm_ruby_string}/bin/unicorn_rails"
set :unicorn_conf, "/etc/unicorn/#{application}.kinley.rb"
set :unicorn_pid, "/var/run/unicorn/#{application}.kinley.pid"

set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"

# - for unicorn - #
namespace :deploy do
  desc "Start application"
  task :start, :roles => :app do
    run unicorn_start_cmd
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT $(cat #{unicorn_pid})"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 $(cat #{unicorn_pid}) || #{unicorn_start_cmd}"
  end
end
