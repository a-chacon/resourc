Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :github, Rails.application.credentials.dig(:github, :app_key),
           Rails.application.credentials.dig(:github, :app_secret), scope: 'read:user,user:email'
  provider :gitlab, Rails.application.credentials.dig(:gitlab, :key),
           Rails.application.credentials.dig(:gitlab, :secret), scope: 'read_user email'
end
