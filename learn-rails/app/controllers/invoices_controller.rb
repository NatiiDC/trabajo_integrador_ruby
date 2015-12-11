class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  def index

    @client = Client.find(params[:client_id])
    @invoices = @client.invoices

  end

  # GET /invoices/1
  def show
    @person = Person.find(@invoice.person_id)
  end

  # GET /invoices/new
  def new
    @client = Client.find(params[:client_id])
    @invoice = Invoice.new
    @people = Person.all
  end

  # GET /invoices/1/edit
  def edit
    @people = Person.all
    @client = Client.find(@invoice.client_id)
  end

  # POST /invoices
  def create
    @client = Client.find(params[:client_id])
    @invoice = @client.invoices.new(invoice_params)

      if @invoice.save
        redirect_to @client, notice: 'La factura ha sido creada.'
      else
        format.html { render :new }
      end
  end

  # PATCH/PUT /invoices/1
  def update
    @client = Client.find(@invoice.client_id)
      if @invoice.update(invoice_params)
        redirect_to client_invoices_path(@client) , notice: 'La factura ha sido actualizada correctamente.'
      else
        format.html { render :edit }
      end
  end

  # DELETE /invoices/1
  def destroy
    @client = Client.find(@invoice.client_id)
    @invoice.destroy
    redirect_to :back, notice: 'La factura ha sido borrada correctamente.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
      # @client = Client.find(params[:client_id])
      # @invoice = @client.invoices.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:client_id, :person_id, :description, :amount, :date_issue)
    end
end
