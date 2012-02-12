module Admin::BaseHelper
  def t_boolean(valor)
    if valor == true
      image_tag 'check_16.gif'
    else
      image_tag 'denied.gif'
    end
  end
end
