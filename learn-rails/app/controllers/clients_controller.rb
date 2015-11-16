class ClientsController < ApplicationController
  def index
  end

  def new
  end

  def create
    # render plain: params[:client].inspect
    @client = Client.new(client_params)

    @client.save
    redirect_to @client

  end

  def show
    # begin
    #   @client = Client.find(params[:id])
    # rescue Exception
    #   redirect_to action:'index'
    # end

    @client = Client.find_by(id: params[:id] )

    if ! @client
      redirect_to action:'index'
    end
  end

  private

  def client_params
    params.require(:client).permit(:firstname, :lastname, :born, :document)
  end

end
