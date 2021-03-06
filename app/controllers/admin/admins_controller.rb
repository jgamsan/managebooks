class Admin::AdminsController < Admin::BaseController
  def index
    @admins = Admin.all
    respond_to do |format|
      format.xml  { render :xml => @admins }
      format.html
    end
  end

  # GET /users/new
  # GET /users/new.xml
  # GET /users/new.json                                    HTML AND AJAX
  #-------------------------------------------------------------------
  def new
    @admin = Admin.new
    respond_to do |format|
      format.xml  { render :xml => @admin }
      format.html
    end
  end

  # GET /users/1
  # GET /users/1.xml
  # GET /users/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  # GET /users/1/edit
  # GET /users/1/edit.xml
  # GET /users/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
    @admin = Admin.find(params[:id])
    respond_to do |format|
      format.json { render :json => @admin }
      format.xml  { render :xml => @admin }
      format.html
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  # DELETE /users/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.json { respond_to_destroy(:ajax) }
      format.xml  { head :ok }
      format.html { redirect_to(admin_admins_path, :notice => 'Se ha borrado un Administrador de Negocio.') }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  # POST /users
  # POST /users.xml
  # POST /users.json                                      HTML AND AJAX
  #-----------------------------------------------------------------
  def create
    @admin = Admin.new(params[:admin])
    @admin.password = Admin.reset_password_token
    @admin.reset_password_token = Admin.reset_password_token
    if @admin.save
      Mailer.first_login_instructions(@admin).deliver
      respond_to do |format|
        format.xml  { head :ok }
        format.html { redirect_to(admin_admins_path, :notice => 'Nuevo Administrador creado correctamente. Se ha enviado email de confirmacion') }
      end
    else
      respond_to do |format|
        format.xml  { head :ok }
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
  end

  def update

    if params[:admin][:password].blank?
      [:password,:password_confirmation].collect{|p| params[:admin].delete(p) }
    end
    @admin = Admin.find(params[:id])
    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        flash[:notice] = "Esta cuenta ha sido actualizada"
        format.json { render :json => @admin.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { redirect_to admin_admins_path }
      else
        format.json { render :text => "No se pudo actualizar el administrador", :status => :unprocessable_entity } #placeholder
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml, :html)
  end
end

