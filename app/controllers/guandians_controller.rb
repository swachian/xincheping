class GuandiansController < ApplicationController
  def index
    @guandians = Guandian.all
  end

  def author
    @guandians = Guandian.where(:editor_id => params[:id]) 
    render :action => :index
  end
end
