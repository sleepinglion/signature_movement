class Faq < ApplicationRecord
  validates_presence_of :title
  belongs_to :faq_category, :autosave => true
  has_one :faq_content, :foreign_key => :id, :dependent => :destroy, inverse_of: :faq
  accepts_nested_attributes_for :faq_content, :allow_destroy => true
end
