class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    # @client = Client.new(firstname: client_params["firstname"],lastname: client_params["lastname"], born: client_params["born"],
    #             type_document_cd: client_params["type_document_cd"],number_document: client_params["number_document"], code: client_params["code"])

    @client = Client.new(client_params)

    if @client.save

      # Contact.new(contact: client_params["email"], client_id: @client.id, contact_type_id: ContactType.where(name_cd: "email").first )
      # Contact.new(contact: client_params["phone"], client_id: @client.id, contact_type_id: ContactType.where(name_cd: "phone").first )
      # Contact.new(contact: client_params["mobile"], client_id: @client.id, contact_type_id: ContactType.where(name_cd: "mobile").first )
      # Contact.new(contact: client_params["address"], client_id: @client.id, contact_type_id: ContactType.where(name_cd: "address").first )

      redirect_to @client
    else
      render 'new'
    end
  end

  def show
    # begin
      @client = Client.find(params[:id])
      @contacts = @client.contacts
    # rescue Exception
    #   redirect_to action:'index'
    # end
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
      msg = "La persona ha sido eliminada."
    else
      msg = "No se pueden eliminar personas con facturas asociadas."
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
