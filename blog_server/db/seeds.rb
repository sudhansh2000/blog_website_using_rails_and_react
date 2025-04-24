user1 = User.find_or_create_by!(
  first_name: "John",
  last_name: "Doe",
  user_name: "johndoe",
  email: "john.doe@example.com",
  phone_number: "1234567890",
  password: BCrypt::Password.create("password123"), # Creating hashed password
  dob: "1990-05-15",
  is_active: true
)

user2 = User.find_or_create_by!(
  first_name: "Jane",
  last_name: "Smith",
  user_name: "janesmith",
  email: "jane.smith@example.com",
  phone_number: "2345678901",
  password: BCrypt::Password.create("password123"),
  dob: "1992-08-20",
  is_active: true
)

puts "Users created successfully!"

# Create Categories (for Post association)
category1 = Category.find_or_create_by!(cat_name: "Technology")
category2 = Category.find_or_create_by!(cat_name: "Lifestyle")
category3 = Category.find_or_create_by!(cat_name: "Health")

puts "Categories created successfully!"

# Create Posts
post1 = Post.find_or_create_by!(
  user: user1,  # User created earlier
  category: category1,  # Category created earlier
  title: "Latest Trends in Tech",
  content: "Technology is evolving rapidly. In this post, we discuss the latest trends in AI, machine learning, and more.",
  is_private: false,
  tags: [ "tech", "innovation", "AI" ]
)

post2 = Post.find_or_create_by!(
  user: user2,
  category: category2,
  title: "10 Tips for a Healthier Life",
  content: "Living a healthy life doesn't have to be complicated. Here are 10 simple tips that can help you achieve better health.",
  is_private: false,
  tags: [ "health", "wellness", "fitness" ]
)

post3 = Post.find_or_create_by!(
  user: user1,
  category: category3,
  title: "The Benefits of Regular Exercise",
  content: "Exercise is an essential part of a healthy lifestyle. In this post, we explore the benefits of regular physical activity.",
  is_private: true,
  tags: [ "exercise", "fitness", "health" ]
)

puts "Posts created successfully!"

# Create Comments
comment1 = Comment.create!(
  user: user1,  # User created earlier
  post: post1,   # Post created earlier
  content: "This is a great read! AI is the future, and it’s fascinating to see its development."
)

comment2 = Comment.create!(
  user: user2,  # User created earlier
  post: post2,   # Post created earlier
  content: "I love these tips! They’re easy to follow and really effective."
)
comment3 = Comment.create!(
  user: user1,  # User created earlier
  post: post3,   # Post created earlier
  content: "I totally agree! Exercise is key to staying healthy, and it boosts mood too."
)


puts "Comments created successfully!"
