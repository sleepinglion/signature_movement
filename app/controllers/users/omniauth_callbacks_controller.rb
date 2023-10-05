class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
  include OmniConcern
  %w[facebook twitter naver google_oauth2 kakao github].each do |meth|
    define_method(meth) do
      create
    end
  end
end
