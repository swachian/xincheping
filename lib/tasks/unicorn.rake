namespace :unicorn do
  desc "重启unicorn"
  task restart: :environment do
     system " if [ -f tmp/pids/unicorn.pid ]; then kill `cat tmp/pids/unicorn.pid`; fi"
    `./bin/unicorn -c unicorn.conf.rb -D`
  end

end
