class Admin::ServiceExtrasController < Admin::BaseController
  def index
    @service_extras = ServiceExtra.by_storeadmin(current_admin_admin.role, current_admin_admin.id)
  end

  def new
    @service_extra = ServiceExtra.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_extra }
    end
  end

  def create
    @service_extra = ServiceExtra.new(params[:service_extra])

    respond_to do |format|
      if @service_extra.save
        format.html { redirect_to(admin_service_extras_path, :notice => 'Nuevo Servicio Extra creado correctamente.') }
        format.xml  { render :xml => @service_extra, :status => :created, :location => @service_extra }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_extra.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @service_extra = ServiceExtra.find(params[:id])

    respond_to do |format|
      if @service_extra.update_attributes(params[:service_extra])
        format.html { redirect_to(@service_extra, :notice => 'Servicio Extra actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service_extra.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @service_extra = ServiceExtra.find(params[:id])
    @service_extra.destroy

    respond_to do |format|
      format.html { redirect_to(admin_service_extras_path) }
      format.xml  { head :ok }
    end
  end

  def edit
    @service_extra = ServiceExtra.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @service_extra }
    end
  end
end

