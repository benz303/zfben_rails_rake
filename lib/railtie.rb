require 'zfben_rails_rake'
require 'rails'
module ZfbenRailsRake
  class Railtie < Rails::Railtie
    railtie_name :zfben_rails_rake

    rake_tasks do
      load File.join(File.dirname(__FILE__), '..', 'tasks/git.rb'
    end
  end
end
