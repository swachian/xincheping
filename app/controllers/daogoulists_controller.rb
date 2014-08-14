class DaogoulistsController < ApplicationController
  def index
    @daogoulists = Daogoulist.all
    
  end
end
