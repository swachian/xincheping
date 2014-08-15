class ChangcesController < ApplicationController
  def new
  end

  def create
  end

  def update
  end

  def index
    @changces = Changce.all.eager_load(:editor)
  end

  def author
    @changces = Changce.where(:editor_id => params[:id]) 
    render :action => :index
  end
end
