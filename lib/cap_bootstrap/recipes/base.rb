Capistrano::Configuration.instance(:must_exist).load do
  def template(from, to)
    erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
    put ERB.new(erb).result(binding), to
  end

  def set_default(name, *args, &block)
    set(name, *args, &block) unless exists?(name)
  end

  namespace :deploy do
    desc "Install everything onto the server"
    task :install do
      run "#{sudo} apt-get -y update"
      run "#{sudo} apt-get -y install python-software-properties"
      run "#{sudo} cd /usr/sbin"
      run "#{sudo} wget http://betamaster.us/blog/wp-content/uploads/2011/11/add-apt-repository"
      run "#{sudo} chmod o+x /usr/sbin/add-apt-repository"
      run "#{sudo} chown root:root /usr/sbin/add-apt-repository"
    end
  end
end
