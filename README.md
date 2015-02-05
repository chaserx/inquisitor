# inquisitor

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

A user should be able to start and stop questions by sending those keywords.

## Development

### Chef + Vagrant

Inquisitor uses Vagrant to build development environments
and foreman to run the required services.

A chef cookbook is also included so you can add it to your Berksfile and
call `inquisitor::development` to create a database and be ready to run.

## Twilio

You'll need to get a Twilio account and a phone number that can SMS. Copy the
dotenv.sample to .env and supply your Twilio keys and phone number.

## Contribution

Pull requests accepted. Please see the [Contribution Guide](CONTRIBUTING.md).
