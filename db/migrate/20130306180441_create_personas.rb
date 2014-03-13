# -*- encoding : utf-8 -*-
class CreatePersonas < ActiveRecord::Migration
  def self.up
    create_table :personas do |t|
      t.string :apellidos, :limit => 60

    end
    create_citier_view(Persona)
  end
  
  def self.down
    drop_citier_view(Persona)
    drop_table :personas
  end
end
