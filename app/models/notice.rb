class Notice < ApplicationRecord
  is_impressionable
  validates_presence_of :title
  validates_length_of :title, :minimum => 4, :maximum => 60
  belongs_to :user, autosave: true
  has_one :notice_content, foreign_key: :id, dependent: :destroy, inverse_of: :notice
  accepts_nested_attributes_for :notice_content, allow_destroy: true, update_only: true

  def notice_content
    super || build_notice_content
  end
end
