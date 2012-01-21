class AddUsersToAdmin < ActiveRecord::Migration
  def change
    Admin.create!({:email => "juan.tato@galiclick.com", :roles => 1, :password => "Local2007", :password_confirmation => "Local2007", :first_name => "Juan", :last_name => "Tato Reguera" })
    Admin.create!({:email => "miguel.gamazo@galiclick.com", :roles => 1, :password => "uha9559", :password_confirmation => "uha9559", :first_name => "Jose Miguel", :last_name => "Gamazo Sanchez" })
  end
end
