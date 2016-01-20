class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create

    @client = Client.new(client_params)

    if @client.save
      redirect_to @client
    else
      render 'new'
    end
  end

  def show
    @client = Client.find(params[:id])
    @contacts = @client.contacts
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    if @client.update(client_params)

      redirect_to @client
    else
      render 'edit'
    end
  end

  def destroy
    @client = Client.find(params[:id])
    if @client.destroy
      msg = "El cliente ha sido eliminada."
    else
      msg = "No se pueden eliminar clientes con facturas asociadas."
    end

    redirect_to clients_path, notice: msg
  end

  def top_five_people()
    @client = Client.find(params[:client_id])
    @people = Client.find(params[:client_id]).invoiced_more_people()

  end

  private

  def client_params
    params
      .require(:client)
      .permit(
        :firstname, :lastname, :born,
        :type_document_cd, :number_document, :code,
        contacts_attributes: [:id, :contact, :contact_type_id, :_destroy])
  end

end
