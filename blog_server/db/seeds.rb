require 'faker'

# Clean the DB (optional in dev)
Like.delete_all
Comment.delete_all
Post.delete_all
Category.delete_all
User.delete_all

puts "🌱 Seeding database..."

# Create Categories
categories = 5.times.map do
  Category.create!(cat_name: Faker::Book.genre)
end

# Create Users
users = 10.times.map do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user_name: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    phone_number: Faker::Number.number(digits: 10),
    password: "password123",
    dob: Faker::Date.birthday(min_age: 18, max_age: 60)
  )
end

# Create Posts
posts = 20.times.map do
  Post.create!(
    user: users.sample,
    category: categories.sample,
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 3),
    is_private: [ true, false ].sample,
    tags: Array.new(3) { Faker::Lorem.unique.word }
  )
end

# Create Comments
comments = 30.times.map do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    content: Faker::Lorem.sentence
  )
end

# Create Replies (nested comments)
10.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    content: Faker::Lorem.question,
    parent: comments.sample
  )
end

# Add Likes on Posts and Comments
# Add Likes on Posts and Comments
30.times do
  user = users.sample
  likeable = (posts + comments).sample

  unless Like.exists?(user: user, liked_on: likeable)
    Like.create!(
      user: user,
      liked_on: likeable
    )
  end
end


puts "✅ Done seeding!"
