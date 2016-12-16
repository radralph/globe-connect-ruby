class LocationQuery < Base

  LOCATION_URL = 'https://devapi.globelabs.com.ph/location/v1/queries/location?access_token=%s&address=%s&requestedAccuracy=%s'

  attr_accessor :access_token

  # Starts up whenever the class is being called.
  #
  # @param string access_token
  # @return LocationQuery
  def initialize(access_token)
    @access_token = access_token
  end

  # Fetches the geolocation of a given address.
  #
  # @param string address
  # @param int    accuracy
  # @return json
  def get_location(address, accuracy = 10)
    # prepare the request url
    url = sprintf(LOCATION_URL, @access_token, address, accuracy)

    # set get request
    response = send_get_request(url)

    return JSON.parse(response)
  end
end
