# inquisitor

[![Build Status](https://semaphoreapp.com/api/v1/projects/ed0f0e84-f00b-45c0-88bc-7d265c0e6538/333373/badge.png)](https://semaphoreapp.com/chaserx/inquisitor)

[![Stories in Ready](https://badge.waffle.io/chaserx/inquisitor.svg?label=ready&title=Ready)](http://waffle.io/chaserx/inquisitor)

## Why?

The idea of Quantified Self is interesting. The practice of QS, however,
requires a bit more effort than I might normally provide. Therefore, having a
system that nags me to record data could be useful. This also another
opportunity to play with Twilio apps.

## Asking Questions; Recording Answers

Background processess orchestrated by Sidekiq will ask users via SMS a series
of questions randomly throughout the day. There's little point in asking
questions while the user is asleep, so some common sense do not distrub times
will be available. A user can reply to that SMS and have the answer recorded,
where the most recent response will answer the last question asked.

### Start and Stop

A user should be able to start and stop all questions by sending those keywords.

## Development

### Chef + Vagrant

Inquisitor uses Vagrant to build development environments
and foreman to run the required services.

A chef cookbook is also included so you can add it to your Berksfile and
call `inquisitor::development` to create a database and be ready to run.

### Bower

Using Bower to manage assets... `bower install` or `bower update`

## Twilio

You'll need to get a Twilio account and a phone number that can SMS. Copy the
dotenv.sample to .env and supply your Twilio keys and phone number.

### Testing Twilio locally

Use [ngrok](https://ngrok.com) to expose your localhost via a tunnel.

1. Download client in VM. `sudo apt-get install ngrok`
1. open tmux; split pane
1. run `foreman start` in one pane and `ngrok -authtoken abc123xyz 3000` where
abc123xyz is your authtoken from your ngrok account.
1. from the ngrok tunnel repl, add your tunnel to your twilio config for your number
messaging config. eg. http://123456789.ngrok.com/sms/receive
1. test away

## Contribution

Pull requests accepted. Please see the [Contribution Guide](CONTRIBUTING.md).
