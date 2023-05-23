class ReportContent < ApplicationRecord
  validates_presence_of :content
  belongs_to :report, :foreign_key => :id, inverse_of: :report_content
end
