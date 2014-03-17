class Pareja < Vinculo
  include ActiveModel::Validations
  acts_as_citier
  
  validate :fechas_unicas

  TIPOS = [
      ['matrimonio', 'mat'],
      ['pareja de hecho', 'pdh'] 
    ]
  
  def fechas_unicas
    if desde.blank? and hasta.blank? then return end
    fechas_unicas_pareja(vinculador_id)
    fechas_unicas_pareja(vinculado_id)
  end
    
  private     
  def fechas_unicas_pareja(persona_id)
    vinculos = Vinculo.find_vinculos_of(persona_id)
    vinculos.each {|v|
      if id == v.id then next end
      if v.desde.blank? and v.hasta.blank? then next end
      if desde.blank? and (v.desde.blank? or v.hasta.blank?) then next end
      if hasta.blank? and (v.desde.blank? or v.hasta.blank?) then next end  
      begin
        range = v.desde..v.hasta
        d = desde
        h = hasta
      rescue Exception => e
        range = desde..hasta
        d = v.desde
        h = v.hasta
      end   
      if range === d
        nombre = Persona.find_by_id(persona_id).nombre
        errors[:base]  << "#{nombre} ya tenia pareja en la fecha 'desde'."
      end
      if range === h
        nombre = Persona.find_by_id(persona_id).nombre
        errors[:base]  << "#{nombre} ya tenia pareja en la fecha 'hasta'."
      end
    }
  end
  
  public
  def get_tipo_pareja
    tipo = TIPOS.transpose
    tipo[0][tipo[1].index(self[:tipo_pareja])]
  end
#  ESTO NO FUNCIONA. SI PONES self[:tipo_pareja] DIRECTAMENTE SI !!!!!!
#  def tipo_pareja
#    tipo = TIPOS.transpose
#    tipo[0][tipo[1].index(self[:tipo_pareja])]
#  end
  
end
