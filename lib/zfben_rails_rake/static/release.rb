ssh 'aws.zfben.com'
remote_path '/home/ubuntu/prod/zfben_db/blog'

before_connect do
  rake 'git:clear'
  rake 'git:push'
end

after_connect do
  rake 'unicorn:stop'
  rake 'git:clear'
  run 'git pull'
  run 'bundle install'
  rake 'unicorn:start[production]'
end
