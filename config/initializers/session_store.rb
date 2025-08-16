if Rails.env.production?
  session_url = 'redis://127.0.0.1:6379/1/session'
  secure = true
  key ='signiture_movement_app_session'
  domain = 'www.anti-kb.site'

  Rails.application.config.session_store :redis_store,
                                         url: session_url,
                                         expire_after: 180.days,
                                         key: key,
                                         domain: domain,
                                         threadsafe: true,
                                         secure: secure,
                                         same_site: :lax,
                                         httponly: true
end