if File.exist? Rails.root.join('config/mongoid.yml')
  namespace :mongodb do
    config = YAML.load(File.read(Rails.root.join('config/mongoid.yml')))
    backup = "mongodump --host #{config['production']['host']} --port #{config['production']['port']}"
    desc backup
    task :dump do
      zfben_rails_rake_system backup
    end

    restore = "mongorestore --host #{config['production']['host']} --port #{config['production']['port']}"
    desc restore
    task :restore do
      zfben_rails_rake_system restore
    end

    desc 'Start Mongodb'
    task :start do
      zfben_rails_rake_system "mkdir #{Rails.root}/mongo" unless File.exists?(Rails.root.join('mongo'))
      zfben_rails_rake_system "mongod --nohttpinterface --nojournal --port #{config['production']['port']} --bind_ip #{config['production']['host']} --dbpath #{Rails.root}/mongo --fork --logpath #{Rails.root}/log/mongodb.log"
    end

    desc 'Stop Mongodb'
    task :stop do
      path = Rails.root.join('mongo/mongod.lock').to_s
      if File.exists?(path)
        zfben_rails_rake_system "kill `cat #{path}`"
        zfben_rails_rake_system 'rm ' + path
      end
    end

    desc 'Clear mongo folder'
    task :clear do
      zfben_rails_rake_system 'rm -r mongo/*'
    end
  end
end
