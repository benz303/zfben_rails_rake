desc 'do remote job'
task :remote, [:job] do |task, args|
  args = args.to_hash
  err 'No job found' unless args.has_key? :job
  job = File.join Rails.root, args[:key] + '.rb'
  err args[:job] + '.rb is not exists!' unless File.exists? release
  
  require 'net/ssh'
  @config = {}
  
  def ssh user_host, *options
    user_host = user_host.split '@'
    if user_host.length != 2
      err 'ssh error, you should set ssh like `username@host`'
    else
      @config[:ssh] = {
        :user => user_host[0],
        :host => user_host[1],
        :options => options[0]
      }
    end
  end
  
  def remote_path path
    @config[:remote_path] = path
  end
  
  def before_connect &block
    if block
      @cmd_list = []
      block.call
      if @cmd_list.length > 0
        @config[:before_connect] = @cmd_list
      end
    end
  end
  
  def after_connect &block
    if block
      @cmd_list = []
      block.call
      if @cmd_list.length > 0
        @config[:after_connect] = @cmd_list
      end
    end
  end
  
  def rake task
    @cmd_list.push 'rake ' + task
  end
  
  def run cmd
    @cmd_list.push 'run ' + cmd
  end
  
  load job
  
  p @config
  
  if @config.has_key?(:before_connect)
    @config[:before_connect].each do |cmd|
      sys cmd
    end
  end
  
  Net::SSH.start(@config[:ssh][:host], @config[:ssh][:user]) do |net|
    @net = net
    def exec cmd
      p "#{@config[:ssh][:user]}@#{@config[:ssh][:host]}: " + cmd
      cmd = "cd #{@config[:remote_path]};#{cmd}"
      channel = @net.open_channel do |ch|
        ch.exec cmd do |ch, success|
          err "could not execute command: #{cmd}" unless success
          
          ch.on_data do |c, data|
            data.split("\n").each{ |s| p s }
          end
          
          ch.on_extended_data do |c, type, data|
            err data
          end
        end
      end
      channel.wait
    end
    
    p 'ssh connect success'
    if @config.has_key?(:after_connect)
      @config[:after_connect].each do |cmd|
        exec cmd
      end
    end
  end
end
