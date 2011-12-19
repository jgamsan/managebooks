class Admin::ResortsController < Admin::ResourcesController
  def index
    @store = Store.find_by_admin_user_id(admin_user.id)
    params.merge!({:store_id => @store.id}) if admin_user.role == "storeadmin"
    super
  end
end