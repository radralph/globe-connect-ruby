class Ussd < Base

  SEND_URL  = 'https://devapi.globelabs.com.ph/ussd/v1/outbound/%s/send/requests?access_token=%s'
  REPLY_URL = 'https://devapi.globelabs.com.ph/ussd/v1/outbound/%s/reply/requests?access_token=%s'

  attr_accessor :access_token, :short_code

  # Starts up whenever the class is being called.
  #
  # @param string access_token
  # @param string short_code
  # @return Ussd
  def initialize(access_token, short_code)
    @access_token = access_token
    @short_code   = short_code
  end

  # @param string address
  # @param string message
  # @param boolean flash
  # @return json
  def send_ussd_request(address, message, flash)
    # set the request url
    url = sprintf(SEND_URL, @short_code, @access_token)

    # set the payload
    payload = {
      "outboundUSSDMessageRequest" => {
        "outboundUSSDMessage" => {
            "message" => message
        },
        "address"       => address,
        "senderAddress" => @short_code,
        "flash"         => flash
      }
    }

    # convert to JSON
    payload = JSON.generate(payload)

    # send post request
    response = send_post_request(url, payload)

    return JSON.parse(response)
  end

  # @param string address
  # @param string message
  # @param string session_id
  # @param boolean flash
  # @return json
  def reply_ussd_request(address, message, session_id, flash)
    # set the request url
    url = sprintf(REPLY_URL, @short_code, @access_token)

    # set the payload
    payload = {
      "outboundUSSDMessageRequest" => {
        "outboundUSSDMessage" => {
            "message" => message
        },
        "address"       => address,
        "senderAddress" => @short_code,
        "sessionID"     => session_id,
        "flash"         => flash
      }
    }

    # convert to JSON
    payload = JSON.generate(payload)

    # send post request
    response = send_post_request(url, payload)

    return JSON.parse(response)
  end
end
