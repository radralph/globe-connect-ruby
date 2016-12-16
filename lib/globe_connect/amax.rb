class Amax < Base

  AMAX_URL = 'https://devapi.globelabs.com.ph/rewards/v1/transactions/send'

  attr_accessor :app_id, :app_secret

  # Starts up whenever the class is being called
  #
  # @param app_id
  # @param app_secret
  # @return Amax
  def initialize(app_id, app_secret)
    @app_id     = app_id
    @app_secret = app_secret
  end

  # Sends reward details to the given address
  #
  # @param address
  # @param promo
  # @param rewards_token
  # @return json
  def send_reward_request(address, promo, rewards_token)
    # set the request url
    url = AMAX_URL

    # set the payload
    payload = {
      "outboundRewardRequest" => {
        "app_id"        => @app_id,
        "app_secret"    => @app_secret,
        "rewards_token" => rewards_token,
        "address"       => address,
        "promo"         => promo
      }
    }

    # convert to JSON
    payload = JSON.generate(payload)

    # send post request
    response = send_post_request(url, payload)

    return JSON.parse(response)
  end
end
