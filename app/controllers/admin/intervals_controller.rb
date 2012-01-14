class Admin::IntervalsController < Admin::BaseController
  def index
    @intervals = Interval.all
  end

  def new
    @interval = Interval.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @interval }
    end
  end

  def create
    @interval = Interval.new(params[:interval])

    respond_to do |format|
      if @interval.save
        format.html { redirect_to(@interval, :notice => 'Nueva categoria creada correctamente.') }
        format.xml  { render :xml => @interval, :status => :created, :location => @interval }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interval.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @interval = Interval.find(params[:id])

    respond_to do |format|
      if @interval.update_attributes(params[:interval])
        format.html { redirect_to(@interval, :notice => 'Categoria actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interval.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @interval = Interval.find(params[:id])
    @interval.destroy

    respond_to do |format|
      format.html { redirect_to(admin_categories_path) }
      format.xml  { head :ok }
    end
  end

  def edit
    @interval = Interval.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @interval }
    end
  end

  def new_by_period
    @interval = Interval.new
  end

  def by_period

  end
end

