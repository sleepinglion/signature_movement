class ModelComment < ApplicationRecord
  validates_presence_of :content
  belongs_to :model, :autosave => true, :counter_cache => true
  belongs_to :user, :autosave => true
  accepts_nested_attributes_for :model, :allow_destroy => true
end
