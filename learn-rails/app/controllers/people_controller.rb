class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'La persona ha sido creada exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /people/1
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'La persona ha sido actualizada exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'La persona ha sido eliminada.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :code)
    end
end
