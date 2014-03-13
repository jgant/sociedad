# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_i18n_locale_from_params
  
  helper_method :usuario_id, :usuario_id=, :nombre_partial, :nombre_partial=
  
  private
  def usuario_id
    session[:usuario_id]
  end
  
  def usuario_id=(key)
    session[:usuario_id] = key
  end

  def nombre_partial
    session[:nombre_partial]
  end
  
  def nombre_partial=(nombre)
    session[:nombre_partial] = nombre
  end

def current_ability
  @current_ability ||= Ability.new(current_usuario)
end
  
  #    El codigo abajo se ha introducido para poder traducir a diferentes
  #     idiomas. Utilizando I18n para Rails.
  #    El idioma por default es español
  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
        " #{params[:locale]} traducción no está disponible"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { :locale => I18n.locale }
  end

  def session_partial(nombre)
    session[:nombre_partial] = nombre
  end

end
