OAuth2::Response.register_parser(:facebook, 'text/plain') do |body|
  key, value = body.split('=')
  {key => value}
end