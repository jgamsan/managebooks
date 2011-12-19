class Admin::BooksController < Admin::ResourcesController
  def index
    @intervals = Interval.list_by_store_admin(admin_user.id)
    params.merge!({:interval_id => @intervals}) if admin_user.role == "storeadmin"
    super
  end
end
