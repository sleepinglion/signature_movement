class Report < ApplicationRecord
  is_impressionable
  acts_as_commentable
  acts_as_votable
  validates_presence_of :title
  belongs_to :user, counter_cache: true
  belongs_to :report_category, counter_cache: true
  has_one :report_content, :foreign_key => :id, :dependent => :destroy, inverse_of: :report
  accepts_nested_attributes_for :report_content, :allow_destroy => true, :update_only => true

  def report_content
    super || build_report_content
  end
end
