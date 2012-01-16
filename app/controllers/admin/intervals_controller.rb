class Admin::IntervalsController < Admin::BaseController
  def index
    @intervals = Interval.page params[:page]
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
    inicio = Time.new(params[:interval][:"time_init(1i)"].to_i, params[:interval][:"time_init(2i)"].to_i, params[:interval][:"time_init(3i)"].to_i, params[:interval][:"time_init(4i)"].to_i, params[:interval][:"time_init(5i)"].to_i)
    fin = Time.new(params[:interval][:"time_finish(1i)"].to_i, params[:interval][:"time_finish(2i)"].to_i, params[:interval][:"time_finish(3i)"].to_i, params[:interval][:"time_finish(4i)"].to_i, params[:interval][:"time_finish(5i)"].to_i)

    i = ((fin - inicio)/(params[:interval][:period].to_i * 60)).to_i
    i.times do |n|
      ini = inicio + (n)*params[:interval][:period].to_i.minute
      final = inicio + (n+1)*params[:interval][:period].to_i.minute
      Interval.create(:resort_id => params[:interval][:resort_id], :init => ini, :finish => final)
    end
    respond_to do |format|
      format.html { redirect_to(admin_intervals_path, :notice => 'Intervalos creados correctamente.') }
      format.xml  { head :ok }
    end
  end
end

