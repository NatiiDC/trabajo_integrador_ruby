class ContactsController < ApplicationController

  # GET /contacts
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      format.html { redirect_to @contact, notice: 'Contacto creado correctamente.' }
    else
      format.html { render :new }
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      format.html { redirect_to @contact, notice: 'Contacto actualizado' }
    else
      format.html { render :edit }
    end
  end

  # DELETE /contacts/1
  def destroy
    if Client.find(@contact.client_id).contacts.count > 2
      @contact.destroy
      format.html { redirect_to clients_url, notice: 'El contacto fue eliminado' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params
        .require(:contact)
        .permit(:contact, :client_id, :contact_type_id)
    end

end
