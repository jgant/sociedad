class CreateParejas < ActiveRecord::Migration

  def self.up
    create_table :parejas do |t|
      t.string :tipo_pareja, :limit => 40
    end
    create_citier_view(Pareja)
  end
  
  def self.down
    drop_citier_view(Pareja)
    drop_table :parejas
  end
end
