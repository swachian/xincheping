class GuandiansController < ApplicationController
  def index
    @guandians = Guandian.order("c_at desc")
  end

  def author
    @guandians = Guandian.where(:editor_id => params[:id]) 
    render :action => :index
  end
end
