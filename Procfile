web: bundle exec puma -p 3000 -S ~/puma -C config/puma.rb --preload
sidekiq: bundle exec sidekiq -L log/sidekiq.log
log: tail -f log/development.log
