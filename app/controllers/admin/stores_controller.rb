class Admin::StoresController < Admin::BaseController
  def index
    @stores = current_admin_admin.role == 1 ? Store.page params[:page] : Store.storeadmin(current_admin_admin.id)
    .page params[:page]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store }
    end
  end

  def new
    @store = Store.new
    @provinces = Province.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store }
    end
  end

  def create
    @store = Store.new(params[:store])

    respond_to do |format|
      if @store.save
        format.html { redirect_to(admin_stores_path, :notice => 'Nuevo Negocio creado correctamente.') }
        format.xml  { render :xml => @store, :status => :created, :location => @store }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to(@store, :notice => 'Negocio actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to(admin_stores_path) }
      format.xml  { head :ok }
    end
  end

  def edit
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @store }
    end
  end
  
  def rules
    @business_rules = BusinessRule.where(:store_id => params[:id]).page params[:page]
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_rule }
    end
  end
  
  def invoice
    @store = Store.find(params[:id])
    @resorts = @store.resorts
    @books = Book.monthly.usuario.by_store(params[:id])
    @books_by_resort = []
    @resorts.each do|resort|
      parcial = Book.by_resort(resort.id)
      @books_by_resort <<parcial.empty? ? [resort.name, 0, 0] : [resort.name, parcial[0].count.to_i, resort.cost.to_f]
    end
    @business_rule = BusinessRule.choose_rule(@books.count).by_store(params[:id]).first
    @total = 0
    unless @books_by_resort.empty?
      @books_by_resort.each do |resort|
        @total += (resort[1] * resort[2] * @business_rule.rule / 100).to_f
      end
    end
  end

  def update_town_select
    @towns = Town.where(:province_id => params[:id]).order(:name) unless params[:id].blank?
    render :partial => "towns", :locals => { :towns => @towns}
  end
end

