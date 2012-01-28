class Admin::BooksController < Admin::BaseController

  def index
   if current_admin_admin.role == 1
     @books = Book.page params[:page]
   else
     @books = Book.storeadmin(current_admin_admin.id).page params[:page]
   end
   
   respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @books }
      format.js
    end
  end

  def para_hoy
    @books = Book.by_storeadmin(current_admin_admin.role, current_admin_admin.id).hoy.page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end

  def tomorrow
    @books = Book.by_storeadmin(current_admin_admin.role, current_admin_admin.id).tomorrow.page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end
  def month
    @books = Book.by_storeadmin(current_admin_admin.role, current_admin_admin.id).month.page params[:page]
    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end
  def range
    @books = Book.by_storeadmin(current_admin_admin.role, current_admin_admin.id).range(params[:init_date], params[:finish_date]).page params[:page]
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
  
  def new
    @book = Book.new
  end

end

