class Payment < Base

  CHARGE_URL          = 'https://devapi.globelabs.com.ph/payment/v1/transactions/amount?access_token=%s'
  LAST_REFERENCE_URL  = 'https://devapi.globelabs.com.ph/payment/v1/transactions/getLastRefCode?app_id=%s&app_secret=%s'

  attr_accessor :access_token, :app_id, :app_secret

  # Starts up whenever the class is being called.
  #
  # @param string app_id
  # @param string app_secret
  # @param string access_token
  # @return Payment
  def initialize(app_id, app_secret, access_token = nil)
    @app_id       = app_id
    @app_secret   = app_secret
    @access_token = access_token
  end

  # Sends payment request.
  #
  # @param float  amount
  # @param string description
  # @param string end_user_id
  # @param string reference_code
  # @param string transaction_operation_status
  # @return json
  def send_payment_request(amount, description, end_user_id, reference_code, transaction_operation_status)
    # set the request url
    url = sprintf(CHARGE_URL, @access_token)

    # make sure that amount has 2 decimal places
    amount = '%.2f' % amount

    # set the payload
    payload = {
      "amount"                      => amount.to_s,
      "description"                 => description,
      "endUserId"                   => end_user_id,
      "referenceCode"               => reference_code,
      "transactionOperationStatus"  => transaction_operation_status
    }

    # convert to JSON
    payload = JSON.generate(payload)

    # send post request
    response = send_post_request(url, payload)

    return JSON.parse(response)
  end

  # Get last reference code request.
  #
  # @return json
  def get_last_reference_code
    # set the url
    url = sprintf(LAST_REFERENCE_URL, @app_id, @app_secret)

    # send response
    response = send_get_request(url)

    return JSON.parse(response)
  end
end
