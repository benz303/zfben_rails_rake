ZfbenRailsRakePath = File.join File.dirname(__FILE__), 'zfben_rails_rake'

module ZfbenRailsRake
  require File.join(ZfbenRailsRakePath, 'railtie.rb') if defined?(Rails)
end
