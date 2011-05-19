namespace :log do
  desc 'analytics log file'
  task :analytics do
    Dir[File.join(Rails.root, 'log', '*.log')].each do |log|
      sys 'request-log-analyzer ' + log
    end
  end
end
