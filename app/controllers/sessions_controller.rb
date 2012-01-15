class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Bienvenido a WebReserva!. Su Reserva aqui"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Vuelva pronto!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
