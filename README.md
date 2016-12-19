# Globe Connect for Ruby

## Introduction
Globe Connect for Ruby platform provides an implementation of Globe APIs e.g Authentication, Amax,
Sms etc. that is easy to use and can be integrated in your existing Ruby application. Below shows
some samples on how to use the API depending on the functionality that you need to integrate in your
application.

## Basic Usage

###### Figure 1. Authentication

```ruby
require 'globe_connect'

authenticate = Authentication.new
url = authenticate.get_access_url('[APP ID]')

response = authenticate.get_access_token('[APP ID]', '[APP_SECRET]', '[CODE]')

puts response
```

###### Figure 2. Amax

```ruby
require 'globe_connect'

amax = Amax.new('[APP ID]', '[APP SECRET]')
response = amax.send_reward_request('[ADDRESS]', '[PROMO NAME]', '[TOKEN]')

puts response
```

###### Figure 3. Binary SMS

```ruby
require 'globe_connect'

binary = Sms.new('[ACCESS TOKEN]', [SHORT CODE])
response = binary.send_binary_message('[ADDRESS]', '[MESSAGE]', '[USER DATA HEADER]')

puts response
```

###### Figure 4. Location

```ruby
require 'globe_connect'

location = LocationQuery.new('[ACCESS TOKEN]')
response = location.get_location('[ADDRESS]', [ACCURACY])

puts response
```

###### Figure 5. Payment (Send Payment Request)

```ruby
require 'globe_connect'

payment = Payment.new('[APP ID]', '[APP SECRET]', '[ACCESS TOKEN]')

response = payment.send_payment_request([AMOUNT], '[DESCRIPTION]', '[ADDRESS]', '[END USER ID]', '[TRANSACTION OPERATION STATUS]')

puts response
```

###### Figure 6. Payment (Get Last Reference ID)

```ruby
require 'globe_connect'

payment = Payment.new('[APP ID]', '[APP SECRET]')
response = payment.get_last_reference_code

puts response
```

###### Figure 7. Sms

```ruby
require 'globe_connect'

sms = Sms.new('[ACCESS TOKEN]', [SHORT CODE])
response = sms.send_message('[ADDRESS]', '[MESSAGE]')

puts response
```

###### Figure 8. Subscriber (Get Balance)

```ruby
require 'globe_connect'

subscriber = Subscriber.new('[ACCESS TOKEN]')
response = subscriber.get_subscriber_balance('[ADDRESS]')

puts response
```

###### Figure 9. Subscriber (Get Reload Amount)

```ruby
require 'globe_connect'

subscriber = Subscriber.new('[ACCESS TOKEN]')
response = subscriber.get_subscriber_reload_amount('[ADDRESS]')
```

###### Figure 10. USSD (Send)

```ruby
require 'globe_connect'

ussd = Ussd.new('[ACCESS TOKEN]', [SHORT CODE])
response = ussd.send_ussd_request('[ADDRESS]', '[MESSAGE]', [FLASH])

puts response
```

###### Figure 11. USSD (Reply)

```ruby
require 'globe_connect'

ussd = Ussd.new('[ACCESS TOKEN]', [SHORT CODE])
response = ussd.reply_ussd_request('[ADDRESS]', '[MESSAGE]', '[SESSION ID]', [FLASH])

puts response
```
