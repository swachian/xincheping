class Zixun < ActiveRecord::Base
  validates_uniqueness_of :link
  belongs_to :editor

  # 对新车评咨询文章进行迭代获取，具体内容的扒取由fetch_one_page执行
  # 具体有业界http://news.xincheping.com/yejie和新车两个出发点
  def self.fetch
    start_url = 'http://news.xincheping.com/yejie'
    doc = Nokogiri::HTML(open("#{start_url}/p1.html"), nil, "GBK")
    my_link = doc.css("a.last-page")[0]['href'] #提取末页的链接后取得总页数
    total_page = $1.to_i if my_link =~ /(\d+)/
    1.upto(2) do |i|
      fetch_one_page("#{start_url}/p#{i}.html")
    end
  rescue Exception => ex
    puts ex
  end

  # 由fetch调用，输入为http://news.xincheping.com/yejie/p2.html
  def self.fetch_one_page(zixunlink)
    puts zixunlink
    doc = Nokogiri::HTML(open(zixunlink), nil, "GBK")
    links = doc.css(".newslist_gncontent h3.fs16 a").select do |link|
      !link['href'].blank?
    end.collect {|link| link['href']}.uniq
    puts links.size
    #links.each {|link| puts link}
    links.each {|link| fetch_one_zixun(link)}

  end

  # http://news.xincheping.com/64691-1.html
  def self.fetch_one_zixun(link)
    puts link
    doc = Nokogiri::HTML(open(link), nil, "GBK")
    zx = {}
    zx[:title] = doc.css("h1.fs24")[0].content
    zx[:link] = link
    author = doc.css("span.news-det-editor")[0].content
    zx[:c_at] = doc.css("span.news-det-ptime")[0].content
    zx[:context] = ''

    #self.add(zx, author)
    p zx
    puts author

  end

  #把fetch_one_page中的数据库操作提取成此函数
  def self.add(zx={}, author)
    self.transaction do
      author = author.split(/\s|、|\//)[0]
      editor = Editor.findauthorforzixun(author, zx[:c_at])
      zx[:editor_id] = editor.id
      Zixun.create!(zixun)
      editor.pingcejia(pc[:c_at])
    end
    rescue
      puts "链接已重复"
      #raise "资讯数据已更新"
  end

end
