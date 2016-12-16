require 'sinatra'
require '../lib/connect_ruby'

before do
  content_type 'application/json'
end

get '/answer' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API.")
  voice.hangup

  content_type :json
  voice.render
end

get '/ask' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API.");

  say = voice.say("Please enter your 5 digit zip code.", {}, true)
  choices = voice.choices({ :value => "[5 DIGITS]" }, true)

  voice.ask({
      :choices => choices,
      :attempts => 3,
      :bargein => false,
      :name => "foo",
      :required => true,
      :say => say,
      :timeout => 10
    })

  voice.on({
      :name => "continue",
      :next => "http://somefakehost.com:8000",
      :required => true
    })

  content_type :json
  voice.render
end

get '/ask-test' do
  voice = Voice.new

  say = voice.say("Please enter your 5 digit zip code.", {}, true)
  choices = voice.choices({:value => "[5 DIGITS]"})

  voice.ask({
      :choices => choices,
      :attempts => 3,
      :bargein => false,
      :name => "foo",
      :required => true,
      :say => say,
      :timeout => 10
    })

  voice.on({
      :name => "continue",
      :next => "http://somefakehost.com:8000",
      :required => true
    })

  content_type :json
  voice.render
end

post '/ask-answer' do
  # get data from post
  payload = JSON.parse(request.body.read)

  voice = Voice.new
  voice.say("Your zip code is " + payload[:result][:actions][:disposition] + ", thank you!")

  content_type :json
  voice.render
end

get '/call' do
  voice = Voice.new

  voice.call({
      :to => "9065263453",
      :from => "906572450"
    })

  say = Array.new
  say << voice.say("Hello world", {}, true)
  voice.say(say)

  content_type :json
  voice.render
end

get '/conference' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API Conference Call.");

  voice.conference({
      :id => "12345",
      :mute => false,
      :name => "foo",
      :play_tones => true,
      :terminator => "#",
      :join_prompt => voice.join_prompt({:value => "http://openovate.com/hold-music.mp3"}, true),
      :leave_prompt => voice.join_prompt({:value => "http://openovate.com/hold-music.mp3"}, true),
    })

  content_type :json
  voice.render
end

get '/event' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API.")

  say1 = voice.say("Sorry, I did not hear anything", {:event => "timeout"}, true)

  say2 = voice.say({
      :value => "Sorry, that was not a valid option.",
      :event => "nomatch:1"
    }, {}, true)

  say3 = voice.say({
      :value => "Nope, still not a valid response",
      :event => "nomatch:2"
    }, {}, true)

  say4 = voice.say({
      :value => "Please enter your 5 digit zip code.",
      :array => [say1, say2, say3]
    }, {}, true)

  choices = voice.choices({ :value => "[5 DIGITS]" }, true)

  voice.ask({
      :choices => choices,
      :attempts => 3,
      :bargein => false,
      :required => true,
      :say => say4,
      :timeout => 5
    })

  voice.on({
      :event => "continue",
      :next => "http://somefakehost:8000/",
      :required => true
    })

  content_type :json
  voice.render
end

get '/hangup' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API, thank you!")
  voice.hangup

  content_type :json
  voice.render
end

get '/routing' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API.");
  voice.on({
    :event => "continue",
    :next => '/routing-1'
  });

  content_type :json
  voice.render
end

get '/routing-1' do
  voice = Voice.new

  voice.say("Hello from resource one!");
  voice.on({
    :event => "continue",
    :next => '/routing-2'
  });

  content_type :json
  voice.render
end

get '/routing-2' do
  voice = Voice.new

  voice.say("Hello from resource two! thank you.");

  content_type :json
  voice.render
end

get '/record' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API.");

  timeout = voice.say(
    "Sorry, I did not hear anything. Please call back.",
    { :event => "timeout"},
    true)

  say = voice.say("Please leave a message", {:array => timeout}, true);

  choices = voice.choices({:terminator => "#"}, true)

  transcription = voice.transcription({
      :id => "1234",
      :url => "mailto:address@email.com"
    }, true)

  voice.record({
      :attempts => 3,
      :bargein => false,
      :method => "POST",
      :required => true,
      :say => say,
      :name => "foo",
      :url => "http://openovate.com/globe.php",
      :format => "audio/wav",
      :choices => choices,
      :transcription => transcription
    })

  content_type :json
  voice.render
end

get '/reject' do
  voice = Voice.new

  voice.reject

  content_type :json
  voice.render
end

get '/say' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API.");
  voice.say("I will play an audio file for you, please wait.");
  voice.say({
      :value => "http://openovate.com/tropo-rocks.mp3"
    })

  content_type :json
  voice.render
end

get '/transfer' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API, you are now being transferred.");

  e1 = voice.say({
    :value => "Sorry, I did not hear anything.",
    :event => "timeout"
  }, {} ,true)

  e2 = voice.say({
    :value => "Sorry, that was not a valid option.",
    :event => "nomatch:1"
  }, {} ,true)

  e3 = voice.say({
    :value => "Nope, still not a valid response",
    :event => "nomatch:2"
  }, {} ,true)

  # TODO: [e1, e2, e3]
  say = voice.say("Please enter your 5 digit zip code", {}, true)

  choices = voice.choices({:value => "[5 DIGITs]"}, true)

  ask = voice.ask({
      :choices => choices,
      :attempts => 3,
      :bargein => false,
      :name => "foo",
      :required => true,
      :say => say,
      :timeout => 5
    }, true)

  ring = voice.on({
      :event => "ring",
      :say => voice.say("http://openovate.com/hold-music.mp3", {} ,true)
    }, true)

  connect = voice.on({
      :event => "connect",
      :ask => ask
    }, true)

  on = voice.on([ring, connect], true)

  voice.transfer({
      :to => "9271223448",
      :ring_repeat => 2,
      :on => on
    })

  content_type :json
  voice.render
end

get '/transfer-whisper' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API, please hold while you are being transferred.");

  say = voice.say("Press 1 to accept this call or any other number to reject", {}, true);

  choices = voice.choices({
      :value => 1,
      :mode => "dtmf"
    }, true)

  ask = voice.ask({
      :choices => choices,
      :name => "color",
      :say => say,
      :timeout => 60
    }, true)

  connect1 = voice.on({
      :event => "connect",
      :ask => ask
    }, true)

  connect2 = voice.on({
      :event => "connect",
      :say => voice.say("You are now being connected", {}, true)
    }, true)

  ring = voice.on({
      :event => "ring",
      :say => voice.say("http://openovate.com/hold-music.mp3", {}, true)
    }, true)

  connect = voice.on([ring, connect1, connect2], true)

  voice.transfer({
      :to => "9271223448",
      :name => "foo",
      :connect => connect,
      :required => true,
      :terminator => "*"
    })

  voice.on({
      :event => "incomplete",
      :next => "/transfer-whisper-hangup",
      :say => voice.say("You are now being disconnected", {}, true)
    })

  content_type :json
  voice.render
end

get '/wait' do
  voice = Voice.new

  voice.say("Welcome to my Tropo Web API, please wait for a while.")
  voice.wait({
      :wait => 5000,
      :allowSignals => true
    })

  voice.say("Thank you for waiting!")

  content_type :json
  voice.render
end
