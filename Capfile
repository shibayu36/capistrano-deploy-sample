load 'config/default' # repositoryの設定とかdeployの設定とか
load 'config/daemontools' # daemontoolsのsvcとか
load 'config/cron' # cronのupdateとか
load 'config/perlbrew'
load 'deploy'

set :application, 'deploy-sample'
set :perlbrew_perl_version, 'perl-5.14.2'

# cap @development deploy => deploy:update + deploy:restart (capistrano)
# ---> top.app.restart, top.worker.restart
# cap @development cron:update
# cap @development perlbrew:install

task '@development' do
  set(:daemontools_service_dir) {
    {
      :app    => "/etc/service/#{application}",
    }
  }

  role :app, 'host01', :perl => true, :daemontools => true

  role :cron, 'host01', :perl => true
  set :crontab_path,         'config/crontab'
  set :crontab_install_name, 'deploy-sample.devel'
end

# deploy用
namespace :deploy do
  task :start do
    top.app.start
    # top.worker.start
  end

  task :stop do
    top.app.stop
    # top.worker.stop
  end

  task :restart do
    top.app.restart
    # top.worker.restart
  end
end

# それぞれのdeploy定義
namespace :app do
  task :start, :roles => :app do
    svc('-u', daemontools_service_dir[:app])
  end

  task :stop, :roles => :app do
    svc('-d', daemontools_service_dir[:app])
  end

  task :restart, :roles => :app do
    svc('-h', daemontools_service_dir[:app])
  end
end

namespace :worker do
  task :start, :roles => :worker do
    svc('-u', daemontools_service_dir[:worker])
  end

  task :stop, :roles => :worker do
    svc('-d', daemontools_service_dir[:worker])
  end

  task :restart, :roles => :worker do
    svc('-t', daemontools_service_dir[:worker])
  end
end
