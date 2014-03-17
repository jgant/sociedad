class Organizacion < Miembro
  acts_as_citier

  def nombre_completo=(ap)
    self[:nombre_completo] = sanea_nombre(ap)
  end
end
