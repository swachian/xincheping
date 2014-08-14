class Daogoulist < ActiveRecord::Base
  validates_uniqueness_of :link
  has_many :daogous

  # 对新车评的导购专题进行获取，根据新车评的专题生成规则
  # http://daogou.xincheping.com/list/1-1-1.html 10w元以下
  # http://daogou.xincheping.com/list/1-2-1.html 10w元
  # 。。。。。。。。。。。。。。。。。。。。。。
  # http://daogou.xincheping.com/list/1-32-1.html
  def self.fetch
    total_zt = 32
    1.upto(total_zt) do |i|
      fetch_one_page("http://daogou.xincheping.com/list/1-#{i}-1.html")
    end
  end

  def self.fetch_one_page(page)
    puts page

    doc = Nokogiri::HTML(open(page), nil, "GBK")
    dgl = {}
    dgl[:link] = page
    dgl[:title] = doc.css(".exp-ls-tit h2")[0].content
    dgl[:alltotalpage] = self.findtotalpage(doc)

    zj_page = page.sub(/\d/, '2')
    doc2 = Nokogiri::HTML(open(zj_page), nil, "GBK")
    dgl[:zjtotalpage] = self.findtotalpage(doc2)
    Daogoulist.create!(dgl)
  rescue Exception => ex
    puts ex
  end

  #每个实际的导购专题才有的方法,调用的是另一个类Daogou的类方法fetch_one_page
  def fetch_all_daogous
    1.upto(alltotalpage) do |n|
      page = link.sub(/\d+\.html/, n.to_s) +".html"
      Daogou.fetch_one_page(page, id)
      puts "done"
    end
  end

  private
  def self.findtotalpage(doc)
    #通过末页的链接获取总的页数
    tlink = doc.css("a.last-page")[0]
    if !tlink.blank?
      $1 if tlink['href'] =~ /\d+-\d+-(\d+)/
    else
       1
    end
  end

end
