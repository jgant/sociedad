class CreateVinculos < ActiveRecord::Migration
  
  def self.up

    create_table :vinculos do |t|
      t.string  :type, :limit => 30    
                         # Contiene el nombre de la clase o subclase. Obligatorio al usar 'citier'
                         # para utilizar multiple table inheritance 
      
      t.integer :vinculador_id
      t.integer :vinculado_id
      t.date :desde
      t.date :hasta

      t.timestamps
    end
  end
  
  def self.down
    drop_table :vinculos
  end
end
