class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where("name ~* ?", "#{params[:q]}")

    results = @users.map(&:attributes)

    results << {:name => "Add: #{params[:q]}", :id => "CREATE_#{params[:q]}_END"}

    respond_to do |format|
      format.html
      format.json { render :json => results  }
    end
  end

  def new
    @user = User.new
    @users = User.where("name ~* ?", "#{params[:q]}")
    respond_to do |format|
      format.html {}
      format.json { render json: @users }
    end
  end
end
