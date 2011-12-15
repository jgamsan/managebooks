class BooksController < ApplicationController
  def list_books
    @books = Book.by_user(current_user.uid)
    respond_to do |format|
      format.js
    end
  end

  def view_daily
    @resort = Resort.find(params[:id])
    @intervals = Book.by_resort(params[:id], Date.today)
    respond_to do |format|
      format.js
    end
  end

  def view_weekly
    fecha = params[:id].to_date
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

  def assign_book
    @resort = Resort.find(params[:id])
    t = Book.new
    t.user_id = current_user.id
    t.resort_id = @resort.id
    t.day = Date.today
    t.interval_id = params[:gd]
    respond_to do |format|
      if t.save
        @intervals = Book.by_resort(@resort.id, Date.today)
        flash[:notice] = "Cita creada correctamente"
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
end
