class ElectronicPolice2 < ActiveRecord::Base
  validates_uniqueness_of :position, scope: :gps

  def self.fetch_one_page()
    # 读取一个json，获得总的page数量
    page ='http://sh.122.gov.cn/m/placesitectrl/loadBusincessList?city=%E6%B2%AAA&page=1&size=15&wdlxdm=29&ywfw='
    response = RestClient.get(page)
    data = JSON.parse(response.body)['data']
    totalPages = data['totalPages']

    # 根据获得page数量进行循环访问
    1.upto(totalPages.to_i) do |pageNo|
      pageNext ="http://sh.122.gov.cn/m/placesitectrl/loadBusincessList?city=%E6%B2%AAA&page=#{pageNo}&size=15&wdlxdm=29&ywfw="
      puts pageNext
      response = RestClient.get(pageNext)
      data = JSON.parse(response.body)['data']
      contents = data['content']
      contents.each do |content|
        ElectronicPolice2.create(position: content['wdmc'], wddm: content['wddm'],
        gps: content['gps'], cjsj: content['cjsj'], gxsj: content['gxsj'] )
        #puts content['wdmc']
      end

    end

  end

  def self.test_fetch_one_page()
    fetch_one_page()
  end
end
