module WelcomeHelper
  def google_api_url
    "http://maps.google.com/maps/api/js"
  end

  def google_api_access
    "#{google_api_url}?v=3.13&sensor=false&libraries=geometry"
  end

  def google_maps_api
    content_tag(:script,:type => "text/javascript",:src => google_api_access) do
    end
  end
end
