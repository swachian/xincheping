class ElectronicPolicesController < ApplicationController
  def list
    perpage = 20
    perpage = 200 if !params[:keyword].blank?
    @eps = ElectronicPolice2.where(['position like ?', "%#{params[:keyword]}%"]).page(params[:page]).per(perpage).order("id asc")
  end
end
