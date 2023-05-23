class NoticeContent < ApplicationRecord
  validates_presence_of :content
  belongs_to :notice, foreign_key: :id, inverse_of: :notice_content
end
