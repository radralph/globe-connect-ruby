class Base

  # Sends request via GET method
  #
  # @param string url
  # @param mixed  payload
  # @return json
  def send_get_request(url, payload = nil)
    # set the uri
    url = URI(url)

    # set http settings
    http              = Net::HTTP.new(url.host, url.port)
    http.use_ssl      = true
    http.verify_mode  = OpenSSL::SSL::VERIFY_NONE

    # set request
    request                   = Net::HTTP::Get.new(url)
    request['content-type']   = 'application/json'
    request['cache-control']  = 'no-cache'

    # send the request and get whatever is the response
    response = http.request(request)

    # return whatever the result
    return response.read_body
  end

  # Sends request via POST method
  #
  # @param string url
  # @param mixed  payload
  # @param string content_type
  # @return json
  def send_post_request(url, payload, content_type = 'application/json')
    # set the uri
    url = URI(url)

    # set http settings
    http              = Net::HTTP.new(url.host, url.port)
    http.use_ssl      = true
    http.verify_mode  = OpenSSL::SSL::VERIFY_NONE

    # set request
    request                   = Net::HTTP::Post.new(url)
    request["content-type"]   = content_type
    request["cache-control"]  = 'no-cache'

    # set the payload
    request.body = payload

    # send the request and get whatever is the response
    response = http.request(request)

    # return the response by reading the body
    return response.read_body
  end
end
