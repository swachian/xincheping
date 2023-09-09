class ElectronicPolice2 < ActiveRecord::Base
  validates_uniqueness_of :position, scope: :gps

  def self.fetch_one_page()
    # 读取一个json，获得总的page数量
    page ='https://sh.122.gov.cn/m/placesitectrl/loadBusincessList?city=%E6%B2%AAA&page=1&size=15&wdlxdm=29&ywfw='
    response = RestClient.get(page, headers = {"Host": "sh.122.gov.cn",
    "Connection": "keep-alive",
    "Cache-Control": "max-age=0",
    "Upgrade-Insecure-Requests": 1,
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
    "Accept-Encoding": "gzip, deflate",
    "Accept-Language": "zh-CN,zh;q=0.9",
    "Cookie": "_uab_collina=152111852665334369800571; _umdata=565BC4B1ED886F10C31F5D0A9E40E18A498B8881170BC1C999ED9EB6BD12F3F1CD4085CF2CCC45A2CD43AD3E795C914C4E8283DB7E35DC0F67A2FF74E08B3C14; __jsluid=f430f60c45d63d0a3d954737271dd5e5; Hm_lvt_d7682ab43891c68a00de46e9ce5b76aa=1549347323; Hm_lpvt_d7682ab43891c68a00de46e9ce5b76aa=1549347363"
    })
    puts response

    data = JSON.parse(response.body)['data']
    totalPages = data['totalPages']
    puts totalPages

    # 根据获得page数量进行循环访问
    1.upto(totalPages.to_i) do |pageNo|
      sleep(1)
      pageNext ="https://sh.122.gov.cn/m/placesitectrl/loadBusincessList?city=%E6%B2%AAA&page=#{pageNo}&size=15&wdlxdm=29&ywfw="
      puts pageNext
      response = RestClient.get(pageNext, headers = {"Host": "sh.122.gov.cn",
      "Connection": "keep-alive",
      "Cache-Control": "max-age=0",
      "Upgrade-Insecure-Requests": 1,
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36",
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
      "Accept-Encoding": "gzip, deflate",
      "Accept-Language": "zh-CN,zh;q=0.9",
      "Cookie": "_uab_collina=152111852665334369800571; _umdata=565BC4B1ED886F10C31F5D0A9E40E18A498B8881170BC1C999ED9EB6BD12F3F1CD4085CF2CCC45A2CD43AD3E795C914C4E8283DB7E35DC0F67A2FF74E08B3C14; __jsluid=f430f60c45d63d0a3d954737271dd5e5; Hm_lvt_d7682ab43891c68a00de46e9ce5b76aa=1549347323; Hm_lpvt_d7682ab43891c68a00de46e9ce5b76aa=1549347363"
      })
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
