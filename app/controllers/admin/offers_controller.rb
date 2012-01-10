class Admin::OffersController < Admin::ResourcesController
  def index
    @resorts = Resort.by_storeadmin(admin_user.id).map {|x| x.id}.flatten
    params.merge!({:resort_id => @resorts}) if admin_user.role == "storeadmin"
    super
  end
end
