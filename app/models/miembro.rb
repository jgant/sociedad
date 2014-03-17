# -*- encoding : utf-8 -*-
class Miembro < ActiveRecord::Base
  acts_as_citier

  has_many :vinculos, :foreign_key => 'vinculador_id'
  has_many :vinculados, :through => :vinculos
  has_many :vinculos_inversos, :class_name => 'Vinculo', :foreign_key => 'vinculado_id'
  has_many :vinculados_inversos, :through => :vinculos_inversos, :source => :vinculador


  # Expresion regular para reconocer letras, acentos, puntos, guiones, superscript a y la letra ñ en una palabra
  PATTERN = Regexp.new(/\A[a-zA-ZñáéíóúüÜÑÁÉÍÓÚÜª\s.-]+\z/)
  EMAIL_PATTERN = Regexp.new(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)

  validates :nombre,
  :presence => {:message => " no admite estar en blanco"},
  :format => {:with => PATTERN, :message => " admite sólo letras y separadores (blanco, punto o guión)", 
              :allow_blank => true}

  def nombre=(n)
    self[:nombre] = sanea_nombre(n)
  end

  def movil=(numero)
    self[:movil] = numero.strip
  end

  #  Da como resultado el nombre y/o apellido de una persona escrito en minúsculas capitalizado.
  def sanea_nombre(nombre)

    #  Los siguientes separadores entre nombres y/o apellidos no se capitalizan
    separadores = %w[de del la las los y]

    #  nombre_sano es el array que contiene todas las palabras y signos del nombre
    nombre_sano = nombre.gsub(/-/, ' - ').mb_chars.downcase.split
    nombre_sano.collect! {|parte| separadores.include?(parte) ? parte : parte.mb_chars.capitalize }
    nombre_sano.join(' ')
  end

end
