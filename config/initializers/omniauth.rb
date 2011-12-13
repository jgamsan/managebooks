Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'B5hHwnEAZEEnkRLAdULxWQ', 'UIpxMuWN9LFSsJlZDlnbcYNDfwpJ7lqGRo6C4urs60'
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  provider :facebook, '275260129193102', '9a59059cb24974d5468a59be2ef0408d'
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end