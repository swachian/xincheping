class ElectronicPolicesController < ApplicationController
  def list
    @eps = ElectronicPolice2.where(['position like ?', "%#{params[:keyword]}%"]).page(params[:page]).per(20)
  end
end
