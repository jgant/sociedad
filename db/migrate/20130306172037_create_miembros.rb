# -*- encoding : utf-8 -*-
class CreateMiembros < ActiveRecord::Migration
  def self.up
    create_table :miembros do |t|
      t.string :type, :limit=> 30
                       # Contiene el nombre de la clase o subclase. Nombre por excepción de la columna para utilizar 
                       #  multiple table inheritance con "citier". Este nombre se puede cambiar utilizando en el modelo
                       # acts_as_citier :db_type_field => 'nombre_columna' pero no funciona 
      t.string :nombre, :limit => 60
      t.string :email, :limit => 60
      t.string :movil, :limit => 20

      t.timestamps
    end
  end
  
  def self.down
    drop_table :miembros
  end
end
