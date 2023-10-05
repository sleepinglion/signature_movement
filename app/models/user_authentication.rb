class UserAuthentication < ApplicationRecord
  belongs_to :user
  belongs_to :authentication_provider
  serialize :params

  def self.create_from_omniauth(params, user, provider)
    token_expires_at = params['credentials']['expires_at'] ? Time.at(params['credentials']['expires_at']).to_datetime : nil
    create(
      user: user,
      authentication_provider: provider,
      uid: params['uid'],
      token: params['credentials']['token'],
      token_expires_at: token_expires_at,
      params: params.to_s
    )
  end

  scope :get_provider_account , -> (user_id,auth_provider_id) { where("user_id = ? and authentication_provider_id = ? ",user_id,auth_provider_id) }
  scope :get_provider_name_account , -> (user_id,auth_provider_name) { where("user_id = ? and authentication_providers.name = ? ",user_id,auth_provider_name).joins(:authentication_provider) }
end
