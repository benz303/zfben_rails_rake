require 'rubygems'
require 'zfben_rails_rake'
require 'rails'
require 'rainbow'
module ZfbenRailsRake
  class Railtie < Rails::Railtie
    railtie_name :zfben_rails_rake
    
    rake_tasks do
      Dir[File.join(ZfbenRailsRakePath, 'tasks', '*')].each{ |f| load f }
    end
  end
end
