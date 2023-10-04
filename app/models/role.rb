class Role < ApplicationRecord
    validates_presence_of :title
    has_many :roles_admin, dependent: :destroy
    has_many :admins, through: :roles_admin, dependent: :destroy
end
