class GuandiansController < ApplicationController
  def index
    
  end

  def author
    @guandians = Guandian.where(:editor_id => params[:id]) 
    render :action => :index
  end
end
