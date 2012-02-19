class Admin::BidsController < Admin::BaseController
  # GET /admin/bids
  # GET /admin/bids.json
  before_filter :get_store
  def index
    @bids = @store.bids

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_bids }
    end
  end

  # GET /admin/bids/1
  # GET /admin/bids/1.json
  def show
    @bid = Bid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_bid }
    end
  end

  # GET /admin/bids/new
  # GET /admin/bids/new.json
  def new
    @bid = Bid.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_bid }
    end
  end

  # GET /admin/bids/1/edit
  def edit
    @bid = Bid.find(params[:id])
  end

  # POST /admin/bids
  # POST /admin/bids.json
  def create
    @bid = Bid.new(params[:bid])

    respond_to do |format|
      if @bid.save
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
    @bid = Bid.find(params[:id])

    respond_to do |format|
      if @bid.update_attributes(params[:bid])
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

  def get_store
    @store = Store.find(params[:store_id])
  end
end

