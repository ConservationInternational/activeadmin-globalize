class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  # Ransack allowlist for searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "created_at", "updated_at"]
  end

  # Ransack allowlist for searchable associations
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
