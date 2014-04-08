class Vinculo < ActiveRecord::Base
  include ActiveModel::Validations

  acts_as_citier :db_type_field => 'tipo_vinculo'
#  attr_accessible :type, :vinculador_id, :vinculado_id, :desde, :hasta
  belongs_to :vinculador, :class_name => 'Miembro'
  belongs_to :vinculado, :class_name => 'Miembro'
  default_scope { order('desde') }

  validate :diferentes_vinculados, :fechas_ordenadas
  
  validates :vinculador_id, :vinculado_id,
    :presence => {:message => ' no admite estar en blanco.' }
  
  
  def diferentes_vinculados
    if vinculador_id == vinculado_id
      errors[:base] << 'La persona no se puede vincular consigo misma.'
    end
  end
  
  def fechas_ordenadas
    if not desde.blank? and not hasta.blank? and (desde > hasta) 
      errors[:base]  << "La fecha 'desde' es mas tarde que la fecha 'hasta'."
    end
  end
  
  def self.find_vinculos_of(persona_id)
     where("vinculador_id = ? OR vinculado_id = ?", persona_id, persona_id)
  end 
  
end
