class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniConcern
  %w[facebook twitter google_oauth2 kakao].each do |meth|
    define_method(meth) do
      create
    end
  end
end
