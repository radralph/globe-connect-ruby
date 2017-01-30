class Sms < Base

  SEND_SMS_URL    = 'https://devapi.globelabs.com.ph/smsmessaging/v1/outbound/%s/requests?access_token=%s'
  BINARY_SMS_URL  = 'https://devapi.globelabs.com.ph/binarymessaging/v1/outbound/%s/requests?access_token=%s'

  attr_accessor :access_token, :short_code

  # Starts up whenever the class is being called.
  #
  # @param string access_token
  # @param string short_code
  # @return Sms
  def initialize(access_token, short_code)
    @access_token = access_token
    @short_code   = short_code
  end

  # Sends a binary sms based on the given address
  #
  # @param string address
  # @param string message
  # @param string header
  # @param string encoding
  # @return json
  def send_binary_message(address, message, header, encoding = nil)
    # format url
    url = sprintf(BINARY_SMS_URL, @short_code, @access_token)

    # prepare the payload
    payload = {
      "outboundBinaryMessageRequest" => {
        "userDataHeader"        => header,
        "dataCodingScheme"      => 1,
        "address"               => address,
        "senderAddress"         => @short_code,
        "access_token"          => @access_token,
        "outboundBinaryMessage" => {
            "message" => message
        },
      }
    }

    # convert to JSON
    payload = JSON.generate(payload)

    # send post request
    response = send_post_request(url, payload)

    return JSON.parse(response)
  end

  # Sends a sms based on the given address
  #
  # @param string address
  # @param string message
  # @param mixed  client_correlator
  # @return json
  def send_message(address, message, client_correlator = nil)
    # set the address format
    addressFormat = 'tel:+63%s'

    # format url
    url = sprintf(SEND_SMS_URL, @short_code, @access_token)

    # set the address
    address = sprintf(addressFormat, address)

    # set the sender
    sender = sprintf(addressFormat, @short_code)

    # prepare the payload
    payload = {
      'outboundSMSMessageRequest' => {
        'senderAddress'           => sender,
        'address'                 => [address],
        'outboundSMSTextMessage'  => {
          'message' => message
        },
      }
    }

    # convert to JSON
    payload = JSON.generate(payload)

    # send post request
    response = send_post_request(url, payload)

    return JSON.parse(response)
  end
end
