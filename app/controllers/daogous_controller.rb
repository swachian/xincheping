class DaogousController < ApplicationController
  def index
    @daogous = Daogou.page(params[:page]).per(50)
    
  end
end
