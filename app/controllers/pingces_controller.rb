class PingcesController < ApplicationController
  def index
    @pingces = Pingce.all.order("jielun asc, c_at desc")
  end

  def author
    @pingces = Pingce.where(:editor_id => params[:id]).order("jielun asc")
    render :action => :index
  end
end
