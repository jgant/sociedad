class CreateOrganizaciones < ActiveRecord::Migration
  def self.up
    create_table :organizaciones do |t|
      t.string :nombre_completo, :limit => 120

    end
    create_citier_view(Organizacion)
  end
  
  def self.down
    drop_citier_view(Organizacion)
    drop_table :organizaciones
  end
end
