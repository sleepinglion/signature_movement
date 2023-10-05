class User < ApplicationRecord
  include OmniauthAttributesConcern
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,  :validatable, :omniauthable, omniauth_providers: [:kakao, :naver, :twitter, :facebook, :apple, :google_oauth2, :github]
  acts_as_voter
  acts_as_votable
  validates_presence_of :name, :email, :on => :create
  validates_length_of :name, within: 1..60
  validates_length_of :email, within: 4..150
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email
  validates :password,confirmation: true, presence: true, length: { minimum: 6 }, allow_nil: true, allow_blank: true
  has_many :user_authorizations

  mount_uploader :photo, UserUploader

  def self.create_from_omniauth(params)
    self.__send__(params.provider, params)
  end
end

