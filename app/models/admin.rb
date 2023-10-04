class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable, :validatable, :timeoutable

  validates_length_of :email, within: 4..40
  validates_uniqueness_of :email
  validates_length_of :name, within: 1..60
  validates_length_of :password, :within => 5..255

  has_one :admin_picture, dependent: :destroy
  has_one :roles_admin
  has_one :role, through: :roles_admin
  has_many :admin_login_log, :dependent=>:destroy
  accepts_nested_attributes_for :admin_picture, :allow_destroy => true

  def role?(role)
    unless self.role.present?
      return false
    end

    if self.role.role==role.to_s
      return true
    else
      return false
    end
  end

  def timeout_in
    1.day
  end
end
