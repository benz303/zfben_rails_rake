namespace 'git' do  
  desc 'git pull'
  task :pull do
    sys 'git pull'
  end

  desc 'git commit with your comment'
  task :commit, :comment do |task, comment|
    unless defined? comment.comment
      comment = 'no comment'
    else
      comment = comment.comment
    end
    sys "git add .;git commit -m '#{comment}' -a"
  end
  
  desc 'git push with your comment'
  task :push, :comment, :needs => :commit do |task, comment|
    sys 'git push'
  end
end
