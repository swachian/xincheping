class ElectronicPolice < ActiveRecord::Base
  def self.fetch_one_page(page)
    puts page
    doc = Nokogiri::HTML(open(page), nil, "GBK")
    tds = doc.css("table table table table table table tr td:nth-child(2)")
    tds[1..-1].each do |td|
      puts td.text
    end
  end

  def self.test_fetch_one_page()
    1.upto(8) do |i|
    page = "http://www.shjtaq.com/zwfg/dzjc_address.asp?key=&page=#{i}"
    fetch_one_page(page)
    end
  end
end
