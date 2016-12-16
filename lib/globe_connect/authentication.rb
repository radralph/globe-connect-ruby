class Authentication < Base

  ACCESS_TOKEN_URL  = 'https://developer.globelabs.com.ph/oauth/access_token'
  REDIRECT_URL      = 'https://developer.globelabs.com.ph/dialog/oauth?app_id=%s'

  # Requests for an access token based on the given app id, app secret, and code
  # that was returned after logging in via WebForm
  #
  # @param string app_id
  # @param string app_secret
  # @param string code
  # @return json
  def get_access_token(app_id, app_secret, code)
    url = ACCESS_TOKEN_URL

    # set body
    query = {
      "app_id"      => app_id,
      "app_secret"  => app_secret,
      "code"        => code
    }

    # hash it
    payload = URI.encode(query.map{|k,v| "#{k}=#{v}"}.join("&"))

    # send post request
    response = send_post_request(url, payload, 'application/x-www-form-urlencoded')

    return JSON.parse(response)
  end

  # Generates the url where the application/user will login
  #
  # @param string app_id
  # @return string
  def get_access_url(app_id)
    return sprintf(REDIRECT_URL, app_id)
  end
end
