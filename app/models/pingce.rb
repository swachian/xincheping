class Pingce < ActiveRecord::Base
  validates_uniqueness_of :link
  belongs_to :editor

  # 对新车评评测文章进行迭代获取，具体内容的扒取由fetch_one_page执行
  def self.fetch
    doc = Nokogiri::HTML(open('http://pingce.xincheping.com/pingce/'), nil, "GBK")
    my_link = doc.css("a.last-page")[0]['href'] #提取末页的链接后取得总页数
    total_page = $1.to_i if my_link =~ /(\d+)/

    1.upto(total_page) do |i|
      fetch_one_page("http://pingce.xincheping.com/pingce/p#{i}.html")
    end
  end


  # 由fetch调用，收入为http://pingce.xincheping.com/pingce/p2.html
  def self.fetch_one_page(page)
    puts page
    doc = Nokogiri::HTML(open(page), nil, "GBK")
    doc.css(".cp_list").each  do |pingce|
      pc = {}
      pc[:title] = pingce.css("h3.fc1 a")[0].content
      pc[:link] = pingce.css("h3.fc1 a")[0]['href']
      pc[:jielun] = pingce.css("li.fc4 img")[0]['src'] if !pingce.css("li.fc4 img").blank?
      pc[:clicks] = pingce.css("span.fc4")[0].content

      doc2 = Nokogiri::HTML(open(pc[:link]), nil, "GBK")
      editinfo = doc2.css(".editinfo p")[0].children()[2].content
      author = $1 if editinfo =~ /作者：(.+) /
      pc[:c_at] = $1 if editinfo =~ /(\d{4}-\d{2}-\d{2})/
      pc[:context] = ''

      self.add(pc, author)
      #p pc
    end
  end

  #把fetch_one_page中的数据库操作提取成此函数
  def self.add(pc={}, author)
    self.transaction do
      author = author.split(/\s|、|\//)[0]
      editor = Editor.findauthorforpingce(author, pc[:c_at])
      pc[:editor_id] = editor.id
      Pingce.create!(pc)
      editor.pingcejia(pc[:c_at])
    end
    rescue
      puts "链接已重复"
  end
end
