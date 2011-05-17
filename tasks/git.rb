namespace 'git' do  
  desc 'git pull'
  task :pull do
    sys 'git pull'
  end

  desc 'git commit with your comment'
  task :commit, :comment do |task, comment|
    if comment == {}
      comment = 'no comment'
    else
      comment = comment.comment
    end
    sys "git commit -m '#{comment}' -a"
  end
  
  desc 'git push with your comment'
  task :push, :comment, :needs => :commit do |task, comment|
    sys 'git push'
  end
end
