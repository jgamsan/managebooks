class Admin::Admins < ActionMailer::Base
  default from: "no-reply@webreserva.me"
  
  def reset_password_instructions(user)
    @admin = user
    mail(:to => user.email, :subject => "Bienvenido al Panel de Control de Webreserva")
  end
end
