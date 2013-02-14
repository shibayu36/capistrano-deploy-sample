set :user, 'app'

set :scm, :git
set :git_shallow_clone, true
set :git_enable_submodules, true

set :deploy_via, :remote_cache

default_run_options[:pty] = true

set :repository do
  "git@githost:projects/#{application}.git"
end

set :deploy_to do
  "/home/app/#{application}"
end

set :password do
  Capistrano::CLI.password_prompt("Password[#{user}]: ")
end

