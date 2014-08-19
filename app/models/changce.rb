class Changce < ActiveRecord::Base
  validates_uniqueness_of :link
  belongs_to :editor

  # 对新车评长测文章进行迭代获取，紧获取正在长测的车型，具体内容的扒取由fetch_one_che执行
  def self.fetch_changceing
    doc = Nokogiri::HTML(open('http://changce.xincheping.com/'), nil, "GBK")
    doc.css("ul.lm_type_list_item")[0].css("li a:first-of-type").collect do |link|
      link['href']
    end.uniq.sort_by{|l| l.to_i}.each do |chelink|
      fetch_one_che(chelink)
    end
  end

  # 对新车评长测文章进行迭代获取，具体内容的扒取由fetch_one_che执行
  def self.fetch
    doc = Nokogiri::HTML(open('http://changce.xincheping.com/'), nil, "GBK")
    doc.css("ul.lm_type_list_item > li a:first-of-type").collect do |link|
      link['href']
    end.uniq.sort_by{|l| l.to_i}.each do |chelink|
      fetch_one_che(chelink)
    end
  end

  # 输入为新车评的某车型入口http://changce.xincheping.com/t2/，然后获取该车型有多少个分页，最后交给fetch_one_page执行
  # chelink = 'http://changce.xincheping.com/t2/'
  def self.fetch_one_che(chelink)
    puts chelink
    doc = Nokogiri::HTML(open(chelink), nil, "GBK")
    pages = doc.css(".pager-inner a").select do |pagelink|
      !pagelink['href'].blank?
    end.collect {|pagelink| pagelink['href']}.uniq
    pages << chelink if pages.size == 0
    pages.each {|page| fetch_one_page(page)}

  end

  # 由fethch_one_che调用，输入为诸如["http://changce.xincheping.com/t2/", "http://changce.xincheping.com/t2/p2.html", "http://changce.xincheping.com/t2/p3.html", "http://changce.xincheping.com/t2/p4.html", "http://changce.xincheping.com/t2/p5.html"]
  # 中的一个
  def self.fetch_one_page(page)
    puts page
    doc = Nokogiri::HTML(open(page), nil, "GBK")
    doc.css(".cclist").each  do |changce|
      cc = {}
      cc[:title] = changce.css(".cc_right h2 a")[0].content

      ar = changce.css(".cc_right span")[0].children()[3].content.strip
      author = $1 if ar =~ /作者：(.+)  /
      cc_left = changce.css(".cc_left")
      cc[:c_at] = cc_left.css("i")[0].content+"-"+cc_left.css("em")[0].content
      cc[:link] = changce.css(".cc_right h2 a")[0]['href']
      cc[:context] = ''
      cc[:chexin] = changce.css(".cc_right span a")[1].content.strip

      self.add(cc, author)
      #p cc
    end
  rescue Exception => ex
    puts ex
  end

  #把fetch_one_page中的数据库操作提取成此函数
  def self.add(cc={}, author)
    self.transaction do
      editor = Editor.findauthorforchangce(author, cc[:c_at])
      cc[:editor_id] = editor.id
      Changce.create!(cc)
      editor.changcejia(cc[:c_at])
    end
    rescue
      puts "链接已重复"
      raise "#{cc[:chexin]}数据已更新"
  end
end
