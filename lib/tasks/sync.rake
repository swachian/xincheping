namespace :sync do
  desc "长测新车评同步"
  task changce: :environment do
    Changce.fetch
  end

  desc "新车评内容全部同步"
  task all: :environment do
    Daogoulist.all.each {|dgl| dgl.sync_daogous(2)}
    Guandian.fetch
    Pingce.fetch
    Changce.fetch_changceing
  end

  desc "同sh.122.gov.cn同步电子警察信息"
  task police2: :environment do
    ElectronicPoloce2.test_fetch_one_page
  end
end
