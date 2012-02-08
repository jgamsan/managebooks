class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :role, :status
  def nombre_completo
    [last_name, first_name].compact.map(&:capitalize).join(", ")
  end
  def update_tracked_fields!(request)
    super
  end

  ROLES = [
    ["admin", 1],
    ["store admin", 2]
  ]
end

