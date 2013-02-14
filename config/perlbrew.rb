load File.dirname(__FILE__) + '/utils.rb'

set :perlbrew_perl_version do
  logger.important 'please set perlbrew_perl_version.'
  abort
end unless exists? :perlbrew_perl_version

set :perlbrew_root, '~app'

set :perlbrew_shell do
  "PERLBREW_HOME=#{perlbrew_root}/.perlbrew . #{perlbrew_root}/perl5/perlbrew/etc/bashrc && perlbrew use #{perlbrew_perl_version} && sh"
end

namespace :perlbrew do
  desc <<-DESC
    perlbrew をインストール
  DESC
  task :install, :only => { :perl => true } do
    act_as_normal_user
    run "#{sudo} yum install -y perlbrew"
  end

  desc <<-DESC
    app のホームディレクトリに perlbrew をセットアップ
  DESC
  task :setup, :only => { :perl => true } do
    if user != 'app'
      logger.important 'perlbrew:setup should be run as hoge'
      abort
    end
    run "perlbrew init"
    run "perlbrew install -v #{perlbrew_perl_version}"
  end
end
