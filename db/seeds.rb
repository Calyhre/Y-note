year = Period.create! title: 'Année 2013-2014', start_at: '30/09/2013', end_at: '11/04/2014'

Period.create! title: 'Trimestre 1', parent: year, start_at: '30/09/2013', end_at: '30/01/2014'
Period.create! title: 'Trimestre 2', parent: year, start_at: '31/01/2014', end_at: '11/04/2014'

users = 30.times.map do |i|
  first_name  = Faker::Name.first_name
  last_name   = Faker::Name.last_name
  email       = "#{first_name.parameterize}.#{last_name.parameterize}@example.com"

  birthdate = Time.at(25.years.ago + rand * (22.years.ago.to_f - 25.years.ago.to_f)).to_date

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: email,
    password_confirmation: email,
    gender: User::GENDERS.sample,
    birthdate: birthdate
  )
end

ing3 = Group.create! title: 'ING3', role: 'student', users: users, period: year

development = Subject.create!( title: 'Development' )
ruby = Subject.create!( title: 'Ruby', parent: development )

ruby_ing3 = GroupSubject.create!( teacher: users.shuffle.first, group: ing3, subject: ruby )
