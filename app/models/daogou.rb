class Daogou < ActiveRecord::Base
  validates_uniqueness_of :link
  belongs_to :daogoulist
  belongs_to :editor

  #获取导购问题汇总的某一页的内容
  #page为http://daogou.xincheping.com/list/1-1-3.html
  def self.fetch_one_page(page, daogoulist_id)
    puts page

    doc = Nokogiri::HTML(open(page), nil, "GBK")
    doc.css(".exp-ls-per-q-tit a").each do |a|
      wt =  a['href']
      self.fetch_one_daogou wt, daogoulist_id
    end
  end

  # 输入具体的问题链接，获得导购的实际内容
  # http://daogou.xincheping.com/101700.html
  def self.fetch_one_daogou(wt, daogoulist_id)
    puts wt
    doc = Nokogiri::HTML(open(wt), nil, "GBK")
    dg = {}
    dg[:title] = doc.css(".exp-det-q-tit h1.fs20")[0].content
    dg[:link] = wt
    dg[:daogoulist_id] = daogoulist_id
    dg[:c_at] = doc.css("span.exp-det-ask-time")[0].content[0..9] if !doc.css("span.exp-det-ask-time").blank?
    dg[:wenti] = doc.css(".exp-det-q-c.fs14")[0].to_html
    zjhd = doc.css(".exp-det-exp-answ-con.fs14")
    if !zjhd.blank?
      dg[:zjhd] = zjhd[0].content
      Daogou.create(dg)
    end
    #p dg
  rescue Exception => ex
    puts ex
  end
end
