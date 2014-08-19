namespace :sync do
  desc "TODO"
  task changce: :environment do
    Changce.fetch
  end

  desc "TODO"
  task all: :environment do
    Daogoulist.all.each {|dgl| dgl.sync_daogous(2)}
    Guandian.fetch
    Pingce.fetch
    Changce.fetch_changceing
  end

end
