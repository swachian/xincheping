class ChangcesController < ApplicationController
  def new
  end

  def create
  end

  def update
  end

  def index
    @changces = Changce.all
  end
end
