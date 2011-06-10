namespace :remote do
  desc 'release project to  remote'
  task :release do
    release = File.join Rails.root, 'release.rb'
    unless File.exists? release
      err 'release.rb is not exists! Please run `rake remote:copy`'
    else
      require 'rubygems'
      require 'net/ssh'
      
      config = {}
      
      def ssh address, *options
        config[:ssh] = [address, options]
      end
      
      def remote_path path
        config[:remote_path] = path
      end
      
      def before_connect &block
        config[:before_connect] = block
      end
      
      def after_connect &block
        config[:after_connect] = block
      end
      
      def rake task
        p 'rake ' + task
      end
      
      def run cmd
        p 'run ' + cmd
      end
      
      p config
    end
  end
end
