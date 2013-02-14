load File.dirname(__FILE__) + '/utils.rb'

def svc(flag, service_dir)
  run "#{sudo} svc #{flag} #{service_dir}"
end
