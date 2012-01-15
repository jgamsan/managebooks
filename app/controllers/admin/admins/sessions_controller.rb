class Admin::Admins::SessionsController < Devise::SessionsController
  layout 'admin/session'

  def new
    @admin = Admin.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin }
    end
  end
end

