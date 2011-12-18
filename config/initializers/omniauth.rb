Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'B5hHwnEAZEEnkRLAdULxWQ', 'UIpxMuWN9LFSsJlZDlnbcYNDfwpJ7lqGRo6C4urs60'
  provider :google_oauth2, '468598197517.apps.googleusercontent.com', '2G6JJeIVACEyzaWjtJtsHW9g'
  provider :facebook, '275260129193102', '9a59059cb24974d5468a59be2ef0408d'
  provider :github, '6a5d0383976fdc103f6e', '15cce3946f10169c8776ba66d327b7ca7cd4f245'
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end