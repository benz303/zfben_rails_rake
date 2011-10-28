p File.exists?(Rails.root + '/config/mongoid.yml')
if File.exists?(Rails.root + '/config/mongoid.yml')
  config = YAML.load(File.read(Rails.root + '/config/mongoid.yml'))
  namespace :mongodb do
    task :backup do
      sys "mongodump --host #{config['production']['host']} --port #{config['production']['port']}"
    end

    task :restore do
      sys "mongorestore --host #{config['production']['host']} --port #{config['production']['port']}"
    end

    task :start do
      path = File.realpath(Rails.root)
      sys "mkdir #{path}/mongo" unless File.exists?(path + '/mongo')
      sys "mongod --nohttpinterface --nojournal --port #{config['production']['port']} --bind_ip #{config['production']['host']} --dbpath #{path}/mongo --fork --logpath #{path}/log/mongodb.log"
    end

    task :stop do
      path = File.realpath(Rails.root) + '/mongo/mongod.lock'
        if File.exists?(path)
          sys "kill `cat #{path}`"
          sys 'rm ' + path
      end
    end
  end
end
