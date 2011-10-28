if File.exist?(ROOT + '/config/mongoid.yml')
  config = YAML.load(File.read(ROOT + '/config/mongoid.yml'))
  namespace :mongodb do
    backup = "mongodump --host #{config['production']['host']} --port #{config['production']['port']}"
    desc backup
    task :backup do
      sys backup
    end

    restore = "mongorestore --host #{config['production']['host']} --port #{config['production']['port']}"
    desc restore
    task :restore do
      sys restore
    end

    desc 'Start Mongodb'
    task :start do
      sys "mkdir #{ROOT}/mongo" unless File.exists?(ROOT + '/mongo')
      sys "mongod --nohttpinterface --nojournal --port #{config['production']['port']} --bind_ip #{config['production']['host']} --dbpath #{ROOT}/mongo --fork --logpath #{ROOT}/log/mongodb.log"
    end

    desc 'Stop Mongodb'
    task :stop do
      path = ROOT + '/mongo/mongod.lock'
      if File.exists?(path)
        sys "kill `cat #{path}`"
        sys 'rm ' + path
      end
    end

    desc 'Clear mongo folder'
    task :clear do
      sys 'rm -r mongo/*'
    end
  end
end
