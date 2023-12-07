class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  self.table_name = "users" # Specify the users table
  enum user_role: { regular: 1, admin: 2 } # Define user_role as an enum

end
