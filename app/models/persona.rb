# -*- encoding : utf-8 -*-
#  encoding: UTF-8
class Persona < Miembro
  acts_as_citier
  
  has_many :usuarios, :dependent => :destroy
  accepts_nested_attributes_for :usuarios
  
  default_scope { order('apellidos') }
  
  self.per_page = 10    # Número de personas que se sacarán de la base de datos para will_paginate

  validates :apellidos, 
    :presence => {:message => " no admite estar en blanco"},
    :format => {:with => PATTERN, 
    			:message => " admite sólo letras y separadores (blanco, punto o guión)",
    			:allow_blank => true}
  
  def apellidos=(ap)
    self[:apellidos] = sanea_nombre(ap)
  end
  
  def apellidos_nombre
    "#{apellidos}, #{nombre}"
  end
end
