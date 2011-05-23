module ZfbenRailsRake
  Path = File.join File.dirname(__FILE__), 'zfben_rails_rake'
  require File.join(Path, 'railtie.rb') if defined?(Rails)
end
