class ComplimentContent < ApplicationRecord
  validates_presence_of :content
  belongs_to :compliment, :foreign_key => :id, inverse_of: :compliment_content
end
