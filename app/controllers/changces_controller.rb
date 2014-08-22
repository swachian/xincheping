class ChangcesController < ApplicationController
  def new
  end

  def create
  end

  def update
  end

  def index
    @changces = Changce.order("chexin asc, changces.c_at desc").eager_load(:editor)
  end

  def author
    @changces = Changce.where(:editor_id => params[:id]).order("c_at desc") 
    render :action => :index
  end
end
