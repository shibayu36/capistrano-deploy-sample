require 'yaml'
require 'open-uri'

def act_as_normal_user
  if !sessions.empty? && user != ENV['USER']
    logger.important "a connection is already established as user #{user}; abort. run tasks separately"
    abort
  end

  set :user, ENV['USER']
  logger.info "running as #{user}"
end

# defaultの値を決める
def set_default(name, *args, &block)
  unless exists?(name)
    set(name, *args, &block)
  end
end
