class RolesAdmin < ApplicationRecord
  belongs_to :role
  belongs_to :admin
  belongs_to :operator, autosave: true, foreign_key: :admin_id
end
