load File.dirname(__FILE__) + '/utils.rb'

desc <<-DESC
crontab を cron マシンにインストールする
以下を設定する必要あり
  :crontab_path - crontab への (リポジトリルートからの) パス
  :crontab_install_name - /etc/cron.d/ に置かれる際の crontab の名前
DESC
namespace :cron do
  task :update, :roles => :cron do
    unless exists?(:crontab_path)
      abort "Please specify the path to crontab file, set :crontab_path, 'config/crontab'"
    end

    unless exists?(:crontab_install_name)
      abort "Please specify the name of installed crontab file, set :crontab_install_name, 'mycrontab'"
    end

    act_as_normal_user

    run <<-CMD
      #{sudo} cp -v #{current_release}/#{crontab_path} /etc/cron.d/#{crontab_install_name} &&
      #{sudo} chown -R root:root /etc/cron.d/ &&
      #{sudo} chmod -R 0644 /etc/cron.d/ &&
      #{sudo} chmod 0700 /etc/cron.d/
    CMD
  end
end
