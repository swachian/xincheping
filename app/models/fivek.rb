class Fivek < ActiveRecord::Base
  def self.fetch
    start_url = 'http://bbs.running8.com/plugin.php?id=run_calculator:run_calculator'
    if page = RestClient.post(start_url, {Hours: 0, Minutes: 33, \
      Seconds: 0, Submit2: "计算", age: "18_34", distance: 5000, sex: "M"})
      puts "Success finding distance."
      npage = Nokogiri::HTML(page)
      peisu_table = npage.css('h2 + table')

      peisu_fenxi peisu_table[1]
    end
  rescue Exception => ex
    puts ex
  end

  def self.peisu_fenxi(peisu_table)
    puts peisu_table.css("tr:nth-child(3)")[0].text

  end
end
