User.create! name:     'Elad Maimon',
             email:    'elad.maimon@gmail.com',
             password: 'foobar'

4.times do |n|
  User.create! name:     Faker::Name.name,
               email:    "temp#{n}@t.com",
               password: 'foobar'
end

(3..5).each { |followed_id| User.first.follow followed_id }
User.last.follow 1

4.times do
  content = Faker::Lorem.sentence 5
  User.find(1).posts.create! content: content
end
