module ZfbenRailsRake
  class Railtie < Rails::Railtie
    railtie_name :zfben_rails_rake  
    rake_tasks do
      path = File.dirname(__FILE__) << '/zfben_rails_rake'
      require path + '/helper.rb'
      Dir[path + '/tasks/*.rb'].each{ |f| require f }
    end
  end
end
