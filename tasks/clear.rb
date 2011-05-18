namespace :clear do
  desc 'clear log folder'
  task :log do
    path = File.join(Rails.root, 'log', '*')
    sys 'rm -r ' << path if Dir[path].length > 0
  end
  
  desc 'clear tmp folder'
  task :tmp do
    path = File.join(Rails.root, 'tmp', '*')
    sys 'rm -r ' << path if Dir[path].length > 0
  end
  
  desc 'clear public folder'
  task :public do
    ['assets', 'caches'].each do |f|
      path = File.join(Rails.root, 'public', f)
      sys 'rm -r ' << path if File.exists? path
    end
  end
  
  desc 'clear all'
  task :all => [:log, :tmp, :public]
end
