# -*- encoding : utf-8 -*-
class PersonasController < ApplicationController

#  before_filter :authenticate_usuario!

  include Devise::Controllers::Helpers
  
  # Es responsable de:
  #   - iniciar la lista de personas registradas en el sistema,
  #   - iniciar la variable del nombre del partial que se 
  #     incorporará a la pantalla de los vínculos, 
  #   - mostrar la lista de personas o bien en formato HTML 
  #     para la pantalla o en formato json.
  # Responde a los URL:
  #   - GET /personas
  #   - GET /personas.json
  def index
    @personas = Persona.paginate(:page => params[:page])
    self.nombre_partial = nil
    respond_to do |format|
      format.html               # index.html.erb
      format.json { render json: @personas }
    end
  end

  # Es responsable de:
  #   - delegar al controlador de los vínculos el mostrar los datos de la persona
  #     seleccionada junto con los datos de sus vínculos,
  #   - responder con los datos de la persona en formato json
  # Responde a los URL:
  #   - GET /personas/1
  #   - GET /personas/1.json
  def show
    usuario_id = params[:id]
    self.nombre_partial = nil
    respond_to do |format|
      format.html { redirect_to vinculos_path(:id => usuario_id) }    # index.html.erb de vinculo
      format.json { render json: Persona.find(usuario_id) }
    end
  end

  # Responde a los URL:
  #   - GET /personas/new
  #   - GET /personas/new.json
  def new
    @persona = Persona.new
    @persona.usuarios.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @persona }
    end
  end

  # GET /personas/1/edit
  def edit
    @persona = Persona.find(params[:id])
  end
  
  # POST /personas
  # POST /personas.json
  def create
    @persona = Persona.new(persona_params)
    respond_to do |format|
      if @persona.save
        format.html { redirect_to vinculos_path(:id => @persona.id), 
                        notice: 'Los datos de la persona se han registrado correctamente.' }
        format.js {}
        format.json { render json: @persona, status: :created, location: @persona }
      else
        format.html { render action: "new" }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
    def persona_params
      params.require(:persona).permit(:nombre, :apellidos, 
        usuarios_attributes: [:id, :email, :password, :password_confirmation, :persona_id])
    end
  
  public
  
  # PUT /personas/1
  # PUT /personas/1.json
  def update
    @persona = Persona.find(params[:id])
    respond_to do |format|
      if @persona.update_attributes(params[:persona])
        self.nombre_partial = nil
        format.html { redirect_to vinculos_path(:id => @persona.id), 
                        notice: 'Los datos de la persona se han modificado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas/1
  # DELETE /personas/1.json
  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy

    respond_to do |format|
      format.html { redirect_to personas_url, 
        notice: 'Los datos de la persona se han borrado del registro.' }
      format.json { head :no_content }
    end
  end
end
