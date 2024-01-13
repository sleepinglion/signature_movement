class Model < ApplicationRecord
  is_impressionable
  acts_as_commentable
  acts_as_votable
  validates_presence_of :title, :recommend_description, :models_comment
  belongs_to :user, :autosave => true
  has_many :model_comment, :dependent => :destroy
  accepts_nested_attributes_for :model_comment, :allow_destroy => true
  mount_uploader :photo, ModelPhotoUploader
end
