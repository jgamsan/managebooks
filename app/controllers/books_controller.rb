class BooksController < ApplicationController
  def list_books
    @books = Book.by_user(current_user.id).page(params[:page]).per(4)
    respond_to do |format|
      format.js do
        if (!params[:page].nil?)
          {:render => 'pagin'}
        else
          {:render => 'list_books'}
        end
      end
    end
  end

  def view_daily
    @resort = Resort.find(params[:id])
    @intervals = Interval.by_resort(params[:id], Date.today)
    respond_to do |format|
      format.js
    end
  end

  def view_weekly
    @resort = Resort.find(params[:id])
    @dia = params[:gd].to_date
    @primero = calculate_first_day(@dia)

    @lunes = calculate_free_books(@resort.id, @primero)
    @martes = calculate_free_books(@resort.id, @primero + 1.day)
    @miercoles = calculate_free_books(@resort.id, @primero + 2.day)
    @jueves = calculate_free_books(@resort.id, @primero + 3.day)
    @viernes = calculate_free_books(@resort.id, @primero + 4.day)
    @sabado = calculate_free_books(@resort.id, @primero + 5.day)
    @domingo = calculate_free_books(@resort.id, @primero + 6.day)
    @intervals = Interval.where(:resort_id => params[:id])
    respond_to do |format|
      format.js
    end
  end

  def get_book
    @interval = Interval.find(params[:id])
    @dia = params[:gd]
    r = @interval.resort_id
    @resort = Resort.find(r)
    @duracion = ((@interval.finish - @interval.init) / 60)
    @horario = @interval.init.strftime("%H:%M").to_s + " - " + @interval.finish.strftime("%H:%M")
    @services_extras = Resort.find(@interval.resort.id).service_extras

    respond_to do |format|
      format.js
    end
  end

  def assign_book
    m = Interval.find(params[:interval])
    r = m.resort_id
    @book = Book.new
    @book.user_id = current_user.id
    @book.day = params[:day].to_date
    @book.interval_id = params[:interval]
    @book.who = "u" + current_user.id.to_s
    @book.service_extra_ids = params[:extra_tokens_ids]
    respond_to do |format|
      if @book.save
        @intervals = Interval.by_resort(r, params[:day])
        @resort = Resort.find(r)
        Mailer.notify_book(current_user.uid, @book).deliver
        flash[:success] = "Cita creada correctamente"
        flash[:notice] = "Tiene una Reserva para el #{l @book.day, :format => '%a,
%d%b%Y'}. En breve recibira un email de confirmacion"
        format.js
      end
    end
  end

  def update_books(resort)
    @resort = Resort.find(resort.id)
    @intervals = Book.by_resort(resort.id, Date.today)
    respond_to do |format|
      format.js
    end
  end

  def change_day
    @dia = params[:gd].to_date
    @resort = params[:id]
    @intervals = Interval.by_resort(@resort, @dia)
    @dia_mas = @dia.to_date + 1.day
    @dia_menos = @dia.to_date - 1.day
    respond_to do |format|
      format.js
    end
  end

  def delete_books
    @book = Book.find(params[:id])
    @book.destroy
    @books = Book.by_user(current_user.uid)
    Mailer.notify_delete_book(current_user.uid, @book).deliver
    respond_to do |format|
      flash[:notice] = "Su reserva ha sido anulada. Se ha enviado un email a su cuenta con la confirmacion"
      format.js { render :js => 'list_books'}
    end
  end

  private

  def calculate_first_day(fecha)
    if fecha.cwday > 5 then
      inicial = fecha + (8 - fecha.cwday)
    else
      inicial = fecha
    end
    if inicial.cweek > fecha.cweek then
      @primero = inicial
    else
      @primero = fecha - fecha.cwday + 1
    end
  end

  def calculate_free_books(resort, fecha)
    Interval.by_resort(resort, fecha).map {|x| x.id}.flatten
  end
end

