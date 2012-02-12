class Admin::IntervalsController < Admin::BaseController
  def index
    if current_admin_admin.role == 1
      @intervals = Interval.page params[:page]
    else
      @intervals = Interval.storeadmin(current_admin_admin.id).page params[:page]
    end

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
        format.html { redirect_to(admin_intervals_path, :notice => 'Nuevo Intervalo creado correctamente.') }
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
        format.html { redirect_to(admin_intervals_path, :notice => 'Intervalo actualizado.') }
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
      format.html { redirect_to(admin_intervals_path) }
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
    inicio = Time.new(Date.today.year, Date.today.month, Date.today.day, params[:interval][:time_init][0..1].to_i, params[:interval][:time_init][3..4].to_i)
    period = params[:interval][:period].to_i.minute
    n = params[:interval][:numero].to_i
    n.times do |n|
      ini = inicio + (n * period)
      final = inicio + (n+1)*period
      @interval = Interval.new
      @interval.resort_id = params[:interval][:resort_id]
      @interval.init = ini
      @interval.finish = final
      @interval.save
    end
    respond_to do |format|
      if @interval.save
        format.html { redirect_to(admin_intervals_path, :notice => 'Intervalos creados correctamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "new_by_period" }
      end
    end
  end
end

