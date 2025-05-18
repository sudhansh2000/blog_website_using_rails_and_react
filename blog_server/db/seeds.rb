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
users = 40.times.map do
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
posts = 60.times.map do
  Post.create!(
    user: users.sample,
    category: categories.sample,
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 30),
    is_private: [ true, false ].sample,
    tags: Array.new(3) { Faker::Lorem.unique.word }
  )
end

# Create Comments
comments = 100.times.map do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    content: Faker::Lorem.sentence
  )
end

# Create Replies (nested comments)
34.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    content: Faker::Lorem.question,
    parent: comments.sample
  )
end

# Add Likes on Posts and Comments
200.times do
  user = users.sample
  likeable = (posts + comments).sample

  unless Like.exists?(user: user, liked_on: likeable)
    Like.create!(user: user, liked_on: likeable)
  end
end

# Bookmarks
users.each do |user|
  2.times do
    post = posts.sample
    Bookmark.find_or_create_by!(user: user, post: post)
  end
end

# Category Preferences
users.each do |user|
  categories.sample(2).each do |category|
    CategoryPreference.find_or_create_by!(user: user, category: category)
  end
end

100.times do
  sender = users.sample
  receiver = (users - [ sender ]).sample
  post = posts.sample

  # Create SharePost with correct sender_id, receiver_id, and post_id
  SharePost.find_or_create_by!(
    sender_id: sender.id,
    receiver_id: receiver.id,
    post_id: post.id
  )
end

puts "✅ Done seeding!"
