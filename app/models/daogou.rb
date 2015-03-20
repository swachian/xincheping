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
  rescue Exception => ex
    puts ex
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
      Daogou.create(dg).find_editor #创造导购记录并确定编辑
    end
    #p dg
  rescue Exception => ex
    puts ex
  end

  #搜索专家回答zjhd，找出全部的回答编辑
  def self.find_editors
    s1 = Set.new
    h1 = {}
    Daogou.all.each do |dg|
      if dg.zjhd =~ /【(车评人|编辑：|编辑；)?(：|\s| |:|：|;|; |；|[[:space:]]|&nbsp;|nbsp;)?(.+)( |[[:space:]])?】/
        zj = $3.strip
        if zj.size > 3
          next
        end
        zj ='盛韶光' if zj == '数十个'
        zj ='许恒生' if zj == '徐恒生'
        zj ='郝舟' if zj =~ /郝舟/
        zj = '邓宣' if zj == '车评人'
        s1 << zj
        count = h1[zj] || 0
        h1[zj] = count + 1
        editor = Editor.findauthorfordaogou(zj, dg.c_at)
        editor.zjhdjia(dg.c_at)
        dg.editor = editor
        dg.save
      end
    end
    s1.each do |zj|
      puts zj + ": " + h1[zj].to_s
      editor = Editor.find_by_name(zj)
      editor.zjhdcount = h1[zj].to_s
      editor.save
    end
    puts s1.reduce(0) {|total, zj| total += h1[zj]}
    s1
  end

  #每个成员有的方法
  def find_editor
    if zjhd =~ /【(车评人|编辑：|编辑；)?(：|\s| |:|：|;|; |；|[[:space:]]|&nbsp;|nbsp;)?(.+)( |[[:space:]])?】/
      zj = $3.strip
      if zj.size > 3
        return
      end
      zj ='盛韶光' if zj == '数十个'
      zj ='许恒生' if zj == '徐恒生'
      zj ='郝舟' if zj =~ /郝舟/
      zj = '邓宣' if zj == '车评人'
      editor = Editor.findauthorfordaogou(zj, c_at)
      editor.zjhdjia(c_at)
      self.editor = editor
      save
    end
  end

end
