class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  def index

    @client = Client.find(params[:client_id])

    if ( params['year'] == "" || params['year'] == "all" )
      @invoices = @client.invoices.order("date_issue DESC").page params[:page]
      params['year'] = "all"
    else
      @year = params['year'] || Time.new.year
      @t1 = Time.new(@year)
      @t2 = Time.new((@year.to_i + 1).to_s)
      @invoices = @client.invoices.where({date_issue: @t1..@t2}).order("date_issue DESC").page params[:page]
      @count = @client.invoices.where({date_issue: @t1..@t2}).count
    end
  end

  def all
    @client = Client.find(params[:client_id])
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

  def amount_per_year
    @year = params['year'] || Time.new.year
    @t1 = Time.new(@year)
    @t2 = Time.new((@year.to_i + 1).to_s)
    @client = Client.find(params[:client_id])
    @invoices = @client.invoices.where({date_issue: @t1..@t2})
    @total_amount = @invoices.inject(0){ |amount, invoice| amount + invoice.amount }
  end

  def cont_per_month
    @year = params['year'] || Time.new.year
    @t1 = Time.new(@year)
    @t2 = Time.new((@year.to_i + 1).to_s)
    @client = Client.find(params[:client_id])
    @invoices = @client.invoices.where({date_issue: @t1..@t2})

    @meses = ['nada', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo',
              'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre',
              'Noviembre', 'Diciembre']
    @cont = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    @invoices.each { |iv|
      @cont[iv.date_issue.month] += 1
      # @cont[iv.date_issue.month] += iv.amount.to_f
      # @cont[iv.date_issue.month] = @cont[iv.date_issue.month].round(2)
    }

  end


  private
    # Use callbacks to share common setup or constraints between actions.

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:client_id, :person_id, :description, :amount, :date_issue)
  end
end
