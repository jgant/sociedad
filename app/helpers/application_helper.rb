# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  private
  
  def current_vinculo_id
    @vinculo_id || 'nada'
  end
  
  def current_vinculo_id=(id)
    @vinculo_id = id
  end

  #  El siguiente código devuelve el nombre del partial que hay que incluir en la pantalla de la persona.
  #  Este nombre se guarda en la sesion.
  
  def session_partial
    session[:nombre_partial]
  end
  
  # Con este codigo se pueden incluir los views de devise en las propias views

  def resource_name
    :usuario
  end

  def resource
    @resource ||= Usuario.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:usuario]
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
