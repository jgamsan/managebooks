class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
    gflash :success => "Bienvenido a WebReserva!. Su Reserva aqui"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
    gflash :success => "Vuelva pronto!"
  end

  def failure
    redirect_to root_url
    gflash :error => "Fallo en la Autenticacion, por favor intentelo de nuevo."
  end
end

