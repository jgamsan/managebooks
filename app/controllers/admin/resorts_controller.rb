class Admin::ResortsController < Admin::BaseController
  def index
    @resorts = Resort.all
  end

  def new
    @resort = Resort.new
    @service_extras = ServiceExtra.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resort }
    end
  end

  def create
    @resort = Resort.new(params[:resort])

    respond_to do |format|
      if @resort.save
        format.html { redirect_to(admin_resorts_path, :notice => 'Nuevo Recurso creado correctamente.') }
        format.xml  { render :xml => @resort, :status => :created, :location => @resort }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resort.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @resort = Resort.find(params[:id])

    respond_to do |format|
      if @resort.update_attributes(params[:resort])
        format.html { redirect_to(admin_resorts_path, :notice => 'Recurso actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resort.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @resort = Resort.find(params[:id])
    @resort.destroy

    respond_to do |format|
      format.html { redirect_to(admin_resorts_path) }
      format.xml  { head :ok }
    end
  end

  def edit
    @resort = Resort.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @resort }
    end
  end
end

