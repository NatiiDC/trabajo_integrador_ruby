class ClientController < ApplicationController
  def index
  end

  def new
  end

  def create
    render plain: params[:clients].inspect
  end

end
