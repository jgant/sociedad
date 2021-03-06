class VinculosController < ApplicationController
  
#  before_filter :authenticate_usuario!
  
  # Diseñado para responder y actuar para todo tipo de vínculos p.e. parejas, empleados, etc.
  # entre miembros de la sociedad: personas y organizaciones.
  # Estos tipos no necesitan controlador alguno. 

  # Responsable de:
  # - iniciar los datos de la persona demandada (:id) y recordar en usuario_id (variable de sesión);
  # - mostrar los datos de la persona y la lista de vínculos del tipo (si) solicitado en :tipo_vínculos
  #   en formato HTML o json;
  # Responde a los URL: 
  # - GET /vinculos
  # - GET /vinculos.json
  def index
    id = params[:id]
    if id.nil?
      @persona = Persona.find(usuario_id)
    else
      if @persona = Persona.find(id)
        self.usuario_id = @persona.id
      else
        return nil
      end
    end
    tipo_vinculos = params[:vinculos]
    if not tipo_vinculos.blank?
      self.nombre_partial = tipo_vinculos + '/index'
      model = tipo_vinculos.classify.constantize      # Converteer el tipo del vinculo en la clase del model
      begin
        @vinculos = model.find_vinculos_of(@persona.id)
		    rescue ActiveRecord::RecordNotFound
		      @vinculos = []
		    end
    end  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: Vinculo.where("vinculador_id = ? || vinculado_id = ?", @persona.id, @persona.id) }
    end
  end

  # Responsable de:
  # - iniciar los datos del vínculo demandado en el parámetro ':id',
  # - iniciar el nombre del partial
  # - responder con los datos del vínculo demandado en formato HTML o json,
  # Necesita:
  # - el :id del vínculo a mostrar
  # Responde a los URL: 
  # - GET /vinculos/1
  # - GET /vinculos/1.json
  def show
    @persona = Persona.find(usuario_id)
    vinculo = Vinculo.find(params[:id])   # encuentra el vinculo en la superclase
    modelo = vinculo.type.constantize           # Converteer el tipo del vinculo en la clase del modelo 
    @vinculo = modelo.find(vinculo.id)    # Inicia el vinculo correcto, aprovecha la MT Inheritance
    self.nombre_partial = @vinculo.type.tableize + '/show'   # Inicia el nombre del partial partiendo del 'type' del vínculo
    respond_to do |format|
      format.html { render 'index' }     
      format.json { render json: @vinculo }
    end
  end

  # GET /vinculos/new
  # GET /vinculos/new.json
  def new
    @persona = Persona.find(usuario_id)       # Inicia la persona
    tipo_vinculos = params[:vinculos]
    model = tipo_vinculos.classify.constantize      # Converteer el tipo del vinculo en la clase del model
    @vinculo = model.new
    @vinculo.type = tipo_vinculos.classify
    @vinculo.vinculador_id = @persona.id            # Inicia el vínculo a crear
    self.nombre_partial = tipo_vinculos + '/new'
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @vinculo }
    end
  end

  # GET /vinculos/1/edit
  def edit
    @persona = Persona.find(usuario_id)
    vinculo = Vinculo.find(params[:id])
    modelo = vinculo.type.constantize  
    @vinculo = modelo.find(params[:id])
    self.nombre_partial = @vinculo.type.tableize + '/edit'
    respond_to do |format|
      format.html { render 'index' }
    end
  end

  # POST /vinculos
  # POST /vinculos.json
  def create
    @persona = Persona.find(usuario_id)
    tipo = params[:vinculo][:type]
    modelo = tipo.constantize      # Convierte el tipo del vinculo en la clase del model
    @vinculo = modelo.new(vinculo_params(tipo))
    respond_to do |format|
      if @vinculo.save
        self.nombre_partial = tipo.tableize + '/index'
        @vinculos = modelo.find_vinculos_of(@persona.id)
        flash[:notice] = 'El vinculo se ha registrado correctamente.'
        format.html { render 'index' }
        format.json { render json: @vinculo, status: :created, location: @vinculo }
      else
        @vinculos = []
        format.html { render 'index' }
        format.json { render json: @vinculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vinculos/1
  # PUT /vinculos/1.json
  def update
    @persona = Persona.find(usuario_id)
    vinculo = Vinculo.find(params[:id])
    modelo = vinculo.type.constantize
    @vinculo = modelo.find(vinculo.id)
    respond_to do |format|
		if @vinculo.update_attributes(vinculo_params(vinculo.type))
        self.nombre_partial = @vinculo.type.tableize << '/show'
        flash[:notice] = 'El vinculo se ha modificado correctamente.'
        format.html { render 'index' }
        format.json { head :no_content }
      else
        format.html { render 'index' }
        format.json { render json: @vinculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vinculos/1
  # DELETE /vinculos/1.json
  def destroy
    @persona = Persona.find(usuario_id)
    vinculo = Vinculo.find(params[:id])
    modelo = vinculo.type.constantize
    @vinculo = modelo.find(vinculo.id)
    @vinculos = modelo.find_vinculos_of(@persona.id)
    self.nombre_partial = @vinculo.type.tableize << '/index'
    @vinculo.destroy
    respond_to do |format|
      flash[:notice] = 'El vinculo se ha borrado del registro.'
      format.html { render 'index' }
      format.json { head :no_content }
    end
  end
  
  private
  
		def vinculo_params(nombre)
			params.require(:vinculo). permit(self.send(nombre.downcase + '_params'))
		end
  	
  	def pareja_params
  		[:type, :vinculador_id, :vinculado_id, :desde, :hasta, :tipo_pareja]
		end
end
