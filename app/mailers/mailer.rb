class Mailer < ActionMailer::Base
  default from: "no-reply@webreserva.me"
  
  def reset_password_instructions(user)
    @admin = user
    mail(:to => "#{user.nombre_completo} <#{user.email}>", :subject => "Bienvenido a la Aplicacion Administrador Webreserva") do |format|
      format.html
    end
  end
  
  def unlock_instructions(user)
    @admin = user
    mail(:to => "#{user.nombre_completo} <#{user.email}>", :subject => "Cuenta bloqueada") do |format|
      format.html
    end
  end
  
  def first_login_instructions(user)
    @admin = user
    mail(:to => "#{user.nombre_completo} <#{user.email}>", :subject => "Bienvenido a la Aplicacion Administrador Webreserva") do |format|
      format.html
    end
  end

  def notify_book(user, book)
    @cliente = Identity.find_by_id(user)
    @reserva = book
    mail(:to => "#{@cliente.name} <#{@cliente.email}>", :subject => "Notificacion de Reserva Disponible") do
    |format|
      format.html
    end
  end

  def notify_delete_book(user, book)
    @cliente = Identity.find_by_id(user)
    @reserva = book
    mail(:to => "#{@cliente.name} <#{@cliente.email}>", :subject => "Notificacion Anulacion de Reserva") do
    |format|
      format.html
    end
  end

end
