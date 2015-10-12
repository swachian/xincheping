class Canting < ActiveRecord::Base

  attr_accessor :doc
  # 对饿了么进行提取
  def self.fetch
    #@doc = Nokogiri::HTML(open('http://ele.me/place/wtw3tkrvq'), nil, "utf8")
    doc = Nokogiri::HTML(open('./elm.html'), nil, "utf8")
    # doc = @doc
    doc.css("a.rstblock").each do |a|
      can_ting = Canting.new
      can_ting.imglink = a.css('img.rstblock-logo-icon')[0]['src']
      can_ting.title1 = a.css('.rstblock-title').text
      can_ting.yueshou = a.css('span.rstblock-monthsales').text
      can_ting.distance = a.css('.rstblock-cost').text
      can_ting.timeleft = a.css('.rstblock-logo span').text
      can_ting.save
    end
  rescue Exception => ex
    puts ex
  end

  def down_load_img
    `wget http:#{imglink} -O /tmp/gse#{id}.jpg`
    self.isimgdownload = 1
    self.save
  end

  def self.down_load_img_all
    Canting.where("isimgdownload=0").each {|c| c.down_load_img}
  end

  def self.export_for_java
    s = ""
    Canting.all.each do |c|
    d1, d2 = c.distance.split(/\//)
s1= <<EOF
      mMap = new HashMap<String,Object>();
      mMap.put("img", R.drawable.gse#{c.id});
      mMap.put("title1", "#{c.title1}");
      str = "\uD83D\uDC66\uD83C\uDFFF";
      result = ""; // EmojiParser.parseToUnicode(str);
      mMap.put("title2", result);
      mMap.put("time", "#{c.yueshou}");
      mMap.put("checked", true);
      mMap.put("distance", "#{d1}");
      mMap.put("timeleft", "#{d2}");
      mList.add(mMap);
EOF
     s += s1
    end
    File.open('/tmp/export.java', 'w+') do |file|
      file.write(s)
    end 
  end

end
