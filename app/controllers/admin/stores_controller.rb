class Admin::StoresController < Admin::BaseController
  def index
    @stores = Store.by_role(current_admin_admin.role, current_admin_admin.id)
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
  
  def update_town_select
    towns = Town.where(:province_id => params[:id]).order(:name) unless params[:id].blank?
    render :partial => "towns", :locals => { :towns => towns}
  end
end

