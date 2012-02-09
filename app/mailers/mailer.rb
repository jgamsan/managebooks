class Mailer < ActionMailer::Base
  default from: "no-reply@webreserva.me"
  
  def reset_password_instructions(user)
    @admin = user
    mail(:to => "#{user.nombre_completo} <#{user.email}>", :subject => "Bienvenido a la Aplicacion Administrador Webreserva") do |format|
      format.html
    end
  end
  
end
