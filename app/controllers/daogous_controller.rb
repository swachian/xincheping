class DaogousController < ApplicationController
  def index
    @daogous = Daogou.page(params[:page]).per(50)

  end

  def author
    @daogous = Daogou.where(:editor_id => params[:id]).page(params[:page]).per(50) 
    render :action => :index
  end

end
