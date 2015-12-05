class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
  end

  def create
    @client = Client.new(client_params)

    @client.save
    redirect_to @client
  end

  def show
    # begin
      @client = Client.find(params[:id])
    # rescue Exception
    #   redirect_to action:'index'
    # end
  end

  private

  def client_params
    params.require(:client).permit(:firstname, :lastname, :born, :type_document_cd, :number_document, :code)
  end

end
