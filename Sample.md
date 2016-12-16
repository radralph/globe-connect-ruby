### AMAX
```ruby
require 'connect_ruby'

amax = Amax.new('5ozgSgeRyeHzacXo55TR65HnqoAESbAz', '3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e')
response = amax.send_reward_request('9271223448', 'LOAD 50', 'token')

puts response
```

### Authentication
```ruby
require 'connect_ruby'

authenticate = Authentication.new
url = authenticate.get_access_url('5ozgSgeRyeHzacXo55TR65HnqoAESbAz')

print url

response = authenticate
  .get_access_token(
    '5ozgSgeRyeHzacXo55TR65HnqoAESbAz',
    '3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e',
    'M8s6gAarub9pebhgEAqKsxdByxHoM5kzf4Mp5js98Bzot8bqjrfaRdG4H4jknpFzr8gKtdx4jnUqbA8KsxqA48frR698IKLRb5S5LBxauo9EkxCMrzk6uorxGEu67Tay49aTxxzu8ozznukMEaXCBRB8GuKjR5MSpB65zIbkA8Bf5eA94se848KUb589RteGkdEFBEddEH6xqRyfjMBqatE4ppBsAe56Bfq4BkjHrXA9Rsqzp5RhMAA6Mu65MAds'
  )

puts response
```

### Location
```ruby
require 'connect_ruby'

location = LocationQuery.new('kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA')
response = location.get_location('09271223448', 10)

puts response
```

### Payment (Send Payment Request)
```ruby
require 'connect_ruby'

payment = Payment.new(
  '5ozgSgeRyeHzacXo55TR65HnqoAESbAz',
  '3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e',
  'kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA'
)

response = payment.send_payment_request(0.00, 'My Application', '9271223448', '41301000116', 'Charged')

puts response
```

### Payment (Get Last Reference Code)
```ruby
require 'connect_ruby'

payment = Payment.new('5ozgSgeRyeHzacXo55TR65HnqoAESbAz', '3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e')
response = payment.get_last_reference_code

puts response
```

### SMS (Send Message)
```ruby
require 'connect_ruby'

sms = Sms.new('kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA', 21584130)
response = sms.send_message('+639271223448', 'Lorem ipsum')

puts response
```

### SMS (Binary Message)
```ruby
require 'connect_ruby'

binary = Sms.new('kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA', 21584130)
response = binary.send_binary_message('09271223448', 'Lorem ipsum', '06050423F423F4')

puts response
```

### Subscriber (Get Subscriber Balance)
```ruby
require 'connect_ruby'

subscriber = Subscriber.new('kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA')
response = subscriber.get_subscriber_balance('639271223448')

puts response
```

### Subscriber (Get Subscriber Reload Amount)
```ruby
require 'connect_ruby'

subscriber = Subscriber.new('kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA')
response = subscriber.get_subscriber_reload_amount('639271223448')
```

### USSD (Send USSD Request)
```ruby
require 'connect_ruby'

ussd = Ussd.new('kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA', 21584130)
response = ussd.send_ussd_request('639271223448', 'Simple USSD Message\nOption - 1\nOption - 2', false)

puts response
```

### USSD (Reply USSD Request)
```ruby
require 'connect_ruby'

ussd = Ussd.new('kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA', 21584130)
response = ussd.reply_ussd_request('639271223448', 'Simple USSD Message\nOption - 1\nOption - 2', '012345678912', false)

puts response
```
