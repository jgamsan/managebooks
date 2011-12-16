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
    @resort = Resort.find(params[:id])
    fecha = params[:gd].to_date
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
    @lunes = Book.by_resort(params[:id], @primero).map {|x| x.id}.flatten
    @martes = Book.by_resort(params[:id], @primero + 1.day).map {|x| x.id}.flatten
    @miercoles = Book.by_resort(params[:id], @primero + 2.day).map {|x| x.id}.flatten
    @jueves = Book.by_resort(params[:id], @primero + 3.day).map {|x| x.id}.flatten
    @viernes = Book.by_resort(params[:id], @primero + 4.day).map {|x| x.id}.flatten
    @sabado = Book.by_resort(params[:id], @primero + 5.day).map {|x| x.id}.flatten
    @domingo = Book.by_resort(params[:id], @primero + 6.day).map {|x| x.id}.flatten
    @intervals = Interval.where(:resort_id => params[:id])
    respond_to do |format|
      format.js
    end
  end

  def assign_book
    r = Interval.find(params[:id]).resort_id
    t = Book.new
    t.user_id = current_user.id
    t.resort_id = r
    t.day = params[:gd]
    t.interval_id = params[:id]
    respond_to do |format|
      if t.save
        @intervals = Book.by_resort(r, Date.today)
        @resort = Resort.find(r)
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

  def next_day

  end

  def previous_day

  end

  def next_week

  end

  def previous_week

  end
end
