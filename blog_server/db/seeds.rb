require 'faker'

# Clear the DB in dependency order
Like.delete_all
Comment.delete_all
Bookmark.delete_all
SharePost.delete_all
CategoryPreference.delete_all
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
30.times do
  user = users.sample
  likeable = (posts + comments).sample

  unless Like.exists?(user: user, liked_on: likeable)
    Like.create!(user: user, liked_on: likeable)
  end
end

# Bookmarks
users.each do |user|
  2.times do
    Bookmark.create!(
      user: user,
      post: posts.sample
    )
  end
end

# Category Preferences
users.each do |user|
  categories.sample(2).each do |category|
    CategoryPreference.find_or_create_by!(user: user, category: category)
  end
end

# Share Posts
10.times do
  sender = users.sample
  receiver = (users - [ sender ]).sample
  post = posts.sample

  SharePost.create!(
    sender: sender,
    receiver: receiver,
    post: post
  )
end

puts "✅ Done seeding!"
