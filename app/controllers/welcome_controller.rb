class WelcomeController < ApplicationController
  def dashboard
    t = Time.now.last_week.sunday
    @changces = Changce.where(["changces.created_at >= ?", t]).order("changces.created_at desc, c_at desc").eager_load(:editor)
    @pingces = Pingce.where(["pingces.created_at >= ?", t]).order("pingces.created_at desc, c_at desc").eager_load(:editor)
    @guandians = Guandian.where(["guandians.created_at >= ?", t]).order("guandians.created_at desc, c_at desc").eager_load(:editor)
    @daogous = Daogou.where(["daogous.created_at >= ?", t]).order("daogous.created_at desc, c_at desc").eager_load(:editor)

    @articles = []
    [@changces, @pingces, @guandians, @daogous].each do |ccs|
      ccs.each do |cc|
        article = {}
        article[:id] = cc.id
        article[:link] = cc.link
        article[:title] = cc.title
        article[:c_at] = cc.c_at
        article[:created_at] = cc.created_at
        if cc.class == Daogou
          article[:context] = cc.zjhd
        else 
          article[:context] = cc.context 
        end
        article[:editor] = cc.editor
        @articles << article
      end
    end

    @articles = @articles.sort_by{|a| a[:created_at]}.reverse
  end
end
