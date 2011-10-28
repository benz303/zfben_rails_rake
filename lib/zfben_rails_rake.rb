ZfbenRailsRakePath = File.join File.dirname(__FILE__), 'zfben_rails_rake'

module ZfbenRailsRake
  if defined?(Rails)
    class Railtie < Rails::Railtie
      railtie_name :zfben_rails_rake
      
      rake_tasks do
        Dir[File.join(ZfbenRailsRakePath, 'tasks', '*')].each{ |f| load f }
      end
    end
  else
    Dir[File.join(ZfbenRailsRakePath, 'tasks', '*')].each{ |f| load f }
  end
end
