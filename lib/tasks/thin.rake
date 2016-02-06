namespace :thin do
  desc "重启thin"
  task restart: :environment do
    system " if [ -f tmp/pids/thin.pid ]; then kill `cat tmp/pids/thin.pid` && rm tmp/pids/thin.pid; fi"
    system  "./bin/thin start --prefix=/xincheping  -p 3001 -P tmp/pids/thin.pid -d"
  end

end
