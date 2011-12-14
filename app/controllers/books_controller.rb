class BooksController < ApplicationController
  def daily
    @resort = Resort.find(params[:id])
    @intervals = Interval.by_resort(params[:id])
    respond_to do |format|
      format.js
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
        @intervals = Interval.by_resort(@resort.id)
        flash[:notice] = "Cita creada correctamente"
        format.js
      end
    end
  end

  def update_books(resort)
    @resort = Resort.find(resort.id)
    @intervals = Interval.byresort(resort.id)
    respond_to do |format|
      format.js
    end
  end
end
