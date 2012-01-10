class Admin::ServiceExtrasController < Admin::ResourcesController
  def index
    @stores = Store.admin(admin_user.id).map {|x| x.id}.flatten
    params.merge!({:store_id => @stores}) if admin_user.role == "storeadmin"
    super
  end
end
