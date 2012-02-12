class Admin::OffersController < Admin::BaseController
  before_filter :get_resort
  def index
    @offers = @resort.offers
  end

  def get_resort
    @resort = Resort.find(params[:resort_id])
  end

  def edit
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @resort }
    end
  end

  def update

  end
end

