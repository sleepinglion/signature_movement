class Propose < ApplicationRecord
  validates_presence_of :title
  belongs_to :user, :autosave => true
end
