puts 'creating user'
user = User.create(email: 'admin@example.com', password: 'password',
                   password_confirmation: 'password',
                   time_zone: 'Eastern Time (US & Canada)')

answers = ['fine', 'ok', 'shitty', 'not so hot', 'like garbade', 'happy', 'manic']
bar = TTY::ProgressBar.new("seeding answers [:bar]", total: answers.size)
question = user.questions.first
answers.size.times do
  question.answers.create(body: answers.sample)
  bar.advance(1)
end
