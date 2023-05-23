class Compliment < ApplicationRecord
  acts_as_votable
  is_impressionable
  validates_presence_of :title
  belongs_to :user, counter_cache: true
  belongs_to :bank, counter_cache: true
  belongs_to :compliment_category, counter_cache: true
  has_one :compliment_content, :foreign_key => :id, :dependent => :destroy, inverse_of: :compliment
  accepts_nested_attributes_for :compliment_content, :allow_destroy => true, :update_only => true

  def compliment_content
    super || build_compliment_content
  end
end
