class Report < ApplicationRecord
  acts_as_votable
  is_impressionable
  validates_presence_of :title
  belongs_to :user, counter_cache: true
  belongs_to :report_category, counter_cache: true
  has_one :report_content, :foreign_key => :id, :dependent => :destroy, inverse_of: :report
  accepts_nested_attributes_for :report_content, :allow_destroy => true, :update_only => true

  def report_content
    super || build_report_content
  end
end
