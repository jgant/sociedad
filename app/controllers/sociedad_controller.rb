class SociedadController < ApplicationController
  def index
  end
  
  def usuario
    redirect_to persona_path(id: current_usuario.persona.id)
  end
end
