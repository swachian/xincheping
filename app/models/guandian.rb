class Guandian < ActiveRecord::Base
  validates_uniqueness_of :link
  belongs_to :editor

  # 对新车评分页的观点文章进行迭代获取，具体内容的扒取由fetch_one_page执行
  def self.fetch
    #http://views.xincheping.com/p2.html
    1.upto(10) do |n|
      page = "http://views.xincheping.com/p#{n}.html"
      fetch_one_page(page)
    end
    rescue Exception => ex
      puts ex
  end

  # 输入为新车评的观点网页集合链接http://views.xincheping.com/p2.html，会扒取该页面上几篇文章的作者和编辑年月信息
  def self.fetch_one_page(page)
    puts page
    doc = Nokogiri::HTML(open(page), nil, "GBK")
    doc.css(".opi-index-per").each  do |guandian|
      gd = {}
      gd[:title] = guandian.css(".opi-index-per-t a")[0].content
      author = guandian.css(".opi-index-author a")[0].content
      gd[:c_at] = guandian.css(".opi-index-time")[0].content
      gd[:link] = guandian.css(".opi-index-per-t a")[0]['href']
      gd[:context] = ''
      #p gd
      self.add(gd, author)
    end
  end

  #把fetch_one_page中的数据库操作提取成此函数
  def self.add(gd={}, author)
    self.transaction do
      editor = Editor.findauthor(author, gd[:c_at])
      gd[:editor_id] = editor.id
      Guandian.create!(gd)
      editor.guandianjia(gd[:c_at])
    end
    rescue
      puts "链接已重复"
      #raise "观点数据已更新"
  end

  #直接抓取http://views.xincheping.com/9-1.html之类的内容
  def self.fetch_one_view(view)
    puts view 
    doc = Nokogiri::HTML(open(view), nil, "GBK")
    gd = {}
    gd[:title] = doc.css(".opi-det-tdt h1.fs24")[0].content
    gd[:c_at] = doc.css(".opi-det-ptime")[0].content
    gd[:link] = view
    gd[:context] = doc.css("#zwnr")[0].content
    author = doc.css(".opi-det-author a")[0].content
    self.add(gd, author)
  rescue =>ex
    p ex
    puts "空链接"
    
  end

  # 通过view的序列直接获取内容
  def self.fetch_all_view
    7.upto(2000) do |n|
      view = "http://views.xincheping.com/#{n}-1.html"
      Guandian.fetch_one_view view
    end
  end

end
