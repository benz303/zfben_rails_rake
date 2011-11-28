module ZfbenRailsRake
  class Railtie < Rails::Railtie
    railtie_name :zfben_rails_rake  
    rake_tasks do
      ZfbenRailsRakePath = File.join File.dirname(__FILE__), 'zfben_rails_rake'
      require ZfbenRailsRakePath + '/helper.rb'
      Dir[File.join(ZfbenRailsRakePath, 'tasks', '*')].each{ |f| require f }
    end
  end
end
