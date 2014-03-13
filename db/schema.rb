# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131028195602) do

  create_table "miembros", :force => true do |t|
    t.string   "type",       :limit => 30
    t.string   "nombre",     :limit => 60
    t.string   "email",      :limit => 60
    t.string   "movil",      :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "organizaciones", :force => true do |t|
    t.string "nombre_completo", :limit => 120
  end

  create_table "parejas", :force => true do |t|
    t.string "tipo_pareja", :limit => 40
  end

  create_table "personas", :force => true do |t|
    t.string "apellidos", :limit => 60
  end

  create_table "usuarios", :force => true do |t|
    t.integer  "persona_id"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

  create_table "vinculos", :force => true do |t|
    t.string   "type",          :limit => 30
    t.integer  "vinculador_id"
    t.integer  "vinculado_id"
    t.date     "desde"
    t.date     "hasta"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_view "view_organizaciones", "SELECT miembros.id, miembros.type, miembros.nombre, miembros.email, miembros.movil, miembros.created_at, miembros.updated_at, organizaciones.nombre_completo FROM miembros, organizaciones WHERE (miembros.id = organizaciones.id);", :force => true do |v|
    v.column :id
    v.column :type
    v.column :nombre
    v.column :email
    v.column :movil
    v.column :created_at
    v.column :updated_at
    v.column :nombre_completo
  end

  create_view "view_parejas", "SELECT vinculos.id, vinculos.type, vinculos.vinculador_id, vinculos.vinculado_id, vinculos.desde, vinculos.hasta, vinculos.created_at, vinculos.updated_at, parejas.tipo_pareja FROM vinculos, parejas WHERE (vinculos.id = parejas.id);", :force => true do |v|
    v.column :id
    v.column :type
    v.column :vinculador_id
    v.column :vinculado_id
    v.column :desde
    v.column :hasta
    v.column :created_at
    v.column :updated_at
    v.column :tipo_pareja
  end

  create_view "view_personas", "SELECT miembros.id, miembros.type, miembros.nombre, miembros.email, miembros.movil, miembros.created_at, miembros.updated_at, personas.apellidos FROM miembros, personas WHERE (miembros.id = personas.id);", :force => true do |v|
    v.column :id
    v.column :type
    v.column :nombre
    v.column :email
    v.column :movil
    v.column :created_at
    v.column :updated_at
    v.column :apellidos
  end

end
