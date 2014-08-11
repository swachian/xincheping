class EditorsController < ApplicationController
  def index
    @editors = Editor.digest
  end

  def status
    @editor = Editor.find(params[:id])
    @editor.status = params[:status]
    @editor.save
    @editors = Editor.digest
    render :index
  end

  def delete
  end

  def create
  end

  def new
  end

  def edit
  end

  def update
  end

  def show
  end
end
