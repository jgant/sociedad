# -*- encoding : utf-8 -*-
require 'test_helper'

class MiembroTest < ActiveSupport::TestCase
  
  test "Los atributos que no pueden estar vacios " do
    miembro = Miembro.new
    assert miembro.invalid?
    assert miembro.errors[:nombre].any?
    assert miembro.errors[:email].any?
  end
  
  test "nombre con solo letras y separadores " do
    miembro = Miembro.new(:nombre => 'juan 1de la Torre',
                          :email => 'juan@jdnnc.es')
    assert miembro.invalid?
    assert miembro.errors[:nombre].any?
  end
end
