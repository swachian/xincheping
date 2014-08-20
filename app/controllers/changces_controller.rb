class ChangcesController < ApplicationController
  def new
  end

  def create
  end

  def update
  end

  def index
    @changces = Changce.order("changces.created_at desc, c_at desc").eager_load(:editor)
  end

  def author
    @changces = Changce.where(:editor_id => params[:id]) 
    render :action => :index
  end
end
