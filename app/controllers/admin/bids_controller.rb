class Admin::BidsController < Admin::BaseController
  # GET /admin/bids
  # GET /admin/bids.json
  def index
    @admin_bids = Bid.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_bids }
    end
  end

  # GET /admin/bids/1
  # GET /admin/bids/1.json
  def show
    @admin_bid = Bid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_bid }
    end
  end

  # GET /admin/bids/new
  # GET /admin/bids/new.json
  def new
    @admin_bid = Bid.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_bid }
    end
  end

  # GET /admin/bids/1/edit
  def edit
    @admin_bid = Bid.find(params[:id])
  end

  # POST /admin/bids
  # POST /admin/bids.json
  def create
    @admin_bid = Bid.new(params[:admin_bid])

    respond_to do |format|
      if @admin_bid.save
        format.html { redirect_to @admin_bid, notice: 'Bid was successfully created.' }
        format.json { render json: @admin_bid, status: :created, location: @admin_bid }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/bids/1
  # PUT /admin/bids/1.json
  def update
    @admin_bid = Bid.find(params[:id])

    respond_to do |format|
      if @admin_bid.update_attributes(params[:admin_bid])
        format.html { redirect_to @admin_bid, notice: 'Bid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/bids/1
  # DELETE /admin/bids/1.json
  def destroy
    @admin_bid = Bid.find(params[:id])
    @admin_bid.destroy

    respond_to do |format|
      format.html { redirect_to admin_bids_url }
      format.json { head :no_content }
    end
  end
end

