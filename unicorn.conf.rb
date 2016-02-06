#encoding: utf-8
ENV["RAILS_ENV"] = 'production'
rails_env = ENV["RAILS_ENV"]
ENV['RAILS_RELATIVE_URL_ROOT'] = '/xincheping'

worker_processes 4
listen "/tmp/.sock", :backlog => 2048
listen 3001, :tcp_nopush => true

timeout 300

app_path =  "."
pid "#{app_path}/tmp/pids/unicorn.pid"

stderr_path "#{app_path}/log/unicorn.stderr.log"
stdout_path "#{app_path}/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  # 参考 http://unicorn.bogomips.org/SIGNALS.html  
  # 使用USR2信号，以及在进程完成后用QUIT信号来实现无缝重启  
  old_pid = "#{app_path}/shared/pids/unicorn.pid.oldbin" 
  if File.exists?(old_pid) && server.pid != old_pid  
    begin  
      Process.kill("QUIT", File.read(old_pid).to_i)  
      puts "kill old unicorn" 
    rescue Errno::ENOENT, Errno::ESRCH  
      # someone else did our job for us  
    end  
  end  
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

end

after_fork do |server, worker|

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

end

