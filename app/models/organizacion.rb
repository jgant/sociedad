class Organizacion < Miembro
  acts_as_citier
  
  attr_accessible :nombre_completo

  def nombre_completo=(ap)
    self[:nombre_completo] = sanea_nombre(ap)
  end
end
