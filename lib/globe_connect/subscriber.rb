class Subscriber < Base

  SUBSCRIBER_BALANCE_URL  = 'https://devapi.globelabs.com.ph/location/v1/queries/balance?access_token=%s&address=%s'
  RELOAD_AMOUNT_URL       = 'https://devapi.globelabs.com.ph/location/v1/queries/reload_amount?access_token=%s&address=%s'

  attr_accessor :access_token

  # Starts up whenever the class is being called.
  #
  # @param string access_token
  # @return Subscriber
  def initialize(access_token)
    @access_token = access_token
  end

  # Get subscriber balance request.
  #
  # @param string address
  # @return json
  def get_subscriber_balance(address)
    # set the request url
    url = sprintf(SUBSCRIBER_BALANCE_URL, @access_token, address)

    # send post request
    response = send_get_request(url)

    return JSON.parse(response)
  end

  # Get subscriber reload amount.
  #
  # @param address
  # @return json
  def get_subscriber_reload_amount(address)
    # set the request url
    url = sprintf(RELOAD_AMOUNT_URL, @access_token, address)

    # send post request
    response = send_get_request(url)

    return JSON.parse(response)
  end
end
