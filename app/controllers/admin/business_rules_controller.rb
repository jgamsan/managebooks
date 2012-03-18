class Admin::BusinessRulesController < Admin::BaseController
  # GET /business_rules
  # GET /business_rules.json
  def index
    @business_rules = BusinessRule.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @business_rules }
    end
  end

  # GET /business_rules/1
  # GET /business_rules/1.json
  def show
    if current_admin_admin.role == 1
      @business_rules = BusinessRule.page params[:page]
    else
      @business_rules = BusinessRule.storeadmin(current_admin_admin.id).page params[:page]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_rule }
    end
  end

  # GET /business_rules/new
  # GET /business_rules/new.json
  def new
    @business_rule = BusinessRule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business_rule }
    end
  end

  # GET /business_rules/1/edit
  def edit
    @business_rule = BusinessRule.find(params[:id])
  end

  # POST /business_rules
  # POST /business_rules.json
  def create
    @business_rule = BusinessRule.new(params[:business_rule])

    respond_to do |format|
      if @business_rule.save
        format.html { redirect_to admin_business_rules_path, notice: 'Regla de Negocios creada correctamente.' }
        format.json { render json: @business_rule, status: :created, location: @business_rule }
      else
        format.html { render action: "new" }
        format.json { render json: @business_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /business_rules/1
  # PUT /business_rules/1.json
  def update
    @business_rule = BusinessRule.find(params[:id])

    respond_to do |format|
      if @business_rule.update_attributes(params[:business_rule])
        format.html { redirect_to admin_business_rules_path, notice: 'Regla de negocios actualizada correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_rules/1
  # DELETE /business_rules/1.json
  def destroy
    @business_rule = BusinessRule.find(params[:id])
    @business_rule.destroy

    respond_to do |format|
      format.html { redirect_to admin_business_rules_path }
      format.json { head :no_content }
    end
  end
end
