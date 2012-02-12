class Admin::DashboardController < Admin::BaseController
  def index
    @books = Book.between_login(current_admin_admin.last_sign_in_at)
  end

end
