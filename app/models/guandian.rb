class Guandian < ActiveRecord::Base
  belongs_to :editor

  # 对新车评分页的观点文章进行迭代获取，具体内容的扒取由fetch_one_page执行
  def self.fetch
    #http://views.xincheping.com/p2.html
    1.upto(137) do |n|
      page = "http://views.xincheping.com/p#{n}.html"
      fetch_one_page(page)
    end
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
      editor = Editor.findauthor(author, gd[:c_at])
      gd[:editor_id] = editor.id
      Guandian.create(gd)
      editor.guandianjia(gd[:c_at])
      #p gd
    end
  end

end
