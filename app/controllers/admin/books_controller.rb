class Admin::BooksController < Admin::BaseController

  def index
   @books = Book.page params[:page]
   respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @books }
      format.js
    end
  end

  def para_hoy
    @books = Book.hoy.page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end

  def tomorrow
    @books = Book.tomorrow.page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end
  def month
    @books = Book.month.page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end
  def range
    @books = Book.range(params[:init_date], params[:finish_date]).page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end

  private

  def parse_dates(fecha)
    fechas = fecha.split('-')
    Date.new(fechas[2].to_i, fechas[1].to_i, fechas[0].to_i)
  end

end

