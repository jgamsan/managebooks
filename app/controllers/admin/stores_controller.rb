class Admin::StoresController < Admin::BaseController
  def index
    if current_admin_admin.role == 1
      @stores = Store.page params[:page]
    else
      @stores = Store.storeadmin(current_admin_admin.id).page params[:page]
    end
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
    if current_admin_admin.role == 1
      @business_rules = BusinessRule.page params[:page]
    else
      @business_rules = BusinessRule.where(:store_id => params[:id]).page params[:page]
      @store = Store.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_rule }
    end
  end
  
  def invoice
    @books = Book.monthly.usuario.by_store(params[:id])
    @store = Store.find(params[:id])
    @books_by_resort = Book.by_resort(params[:id])
    @business_rule = BusinessRule.choose_rule(@books.count).by_store(params[:id]).first
    @total = 0
    unless @books_by_resort.nil?
      @books_by_resort.each do |resort|
        @total += (resort.count.to_i * resort.cost.to_f * @business_rule.rule / 100).to_f
      end
    end
  end

  def update_town_select
    towns = Town.where(:province_id => params[:id]).order(:name) unless params[:id].blank?
    render :partial => "towns", :locals => { :towns => towns}
  end
end

