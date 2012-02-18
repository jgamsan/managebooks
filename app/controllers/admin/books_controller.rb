class Admin::BooksController < Admin::BaseController

  before_filter :get_store, :only => [:new, :create, :update_day_selected]
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

  def new
    @book = Book.new
    @intervals = Interval.for_select(@store, Date.today)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @books }
    end
  end

  def create
    @book = Book.new(params[:book])
    @book.who = "a" + @book.user_id.to_s

    respond_to do |format|
      if @book.save
        format.html { redirect_to(admin_books_path, :notice => 'Nueva Reserva creada correctamente.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(admin_books_path) }
      format.xml  { head :ok }
    end
  end

  def para_hoy
    if current_admin_admin.role == 1
      @books = Book.hoy.page params[:page]
    else
      @books = Book.storeadmin(current_admin_admin.id).hoy.page params[:page]
    end

    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end

  def tomorrow
    if current_admin_admin.role == 1
      @books = Book.tomorrow.page params[:page]
    else
      @books = Book.storeadmin(current_admin_admin.id).tomorrow.page params[:page]
    end

    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end
  def month
    if current_admin_admin.role == 1
      @books = Book.month.page params[:page]
    else
      @books = Book.storeadmin(current_admin_admin.id).month.page params[:page]
    end

    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end
  def range
    if current_admin_admin.role == 1
      @books = Book.range(params[:init_date], params[:finish_date]).page params[:page]
    else
      @books = Book.storeadmin(current_admin_admin.id).range(params[:init_date], params[:finish_date]).page params[:page]
    end

    respond_to do |format|
      format.html {index.erb}
      format.xml  { render :xml => @books }
      format.js
    end
  end

  def update_day_selected
    intervals = Interval.for_select(@store, params[:id]) unless params[:id].blank?
    render :partial => "intervals", :locals => { :intervals => intervals}
  end
  
  def update_interval_select
    @interval = Interval.find(params[:id])
    services_extras = Resort.find(@interval.resort.id).service_extras
    render :partial => "services_extras", :locals => { :services_extras => services_extras}
  end

  def get_store
    @store = Store.find_by_admin_id(current_admin_admin.id)
  end
  private

  def parse_dates(fecha)
    fechas = fecha.split('-')
    Date.new(fechas[2].to_i, fechas[1].to_i, fechas[0].to_i)
  end
end

