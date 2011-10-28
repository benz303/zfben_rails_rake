ZfbenRailsRakePath = File.join File.dirname(__FILE__), 'zfben_rails_rake'

if defined? Rails
  module ZfbenRailsRake
    class Railtie < Rails::Railtie
      railtie_name :zfben_rails_rake  
      rake_tasks do
        require ZfbenRailsRakePath + '/helper.rb'
        Dir[File.join(ZfbenRailsRakePath, 'tasks', '*')].each{ |f| require f }
      end
    end
  end
else
  require ZfbenRailsRakePath + '/helper.rb'
  Dir[File.join(ZfbenRailsRakePath, 'tasks', '*')].each{ |f| require f }
  task :default do
    p 'ok'
  end
end
