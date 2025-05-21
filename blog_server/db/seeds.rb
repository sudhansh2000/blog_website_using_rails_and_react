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

post_content = {
  "time": 1747814955914,
  "blocks": [
    {
      "id": "hrbrI_gVh2",
      "type": "image",
      "data": {
        "caption": "",
        "withBorder": false,
        "withBackground": false,
        "stretched": false,
        "file": {
          "url": "http://localhost:3001/uploads/d7a2db56e5309206f554cb4bb6e4fafe.webp"
        }
      }
    },
    {
      "id": "Fsl8OW_yMH",
      "type": "paragraph",
      "data": {
        "text": "Last month, 350 people joined&nbsp;<a href=\"https://blog.medium.com/draft-day-2025-live-blog-5d3f4d4b022b\">Draft Day 2025</a>&nbsp;in the live Zoom event, dug through their drafts folder on Medium, found a dusty draft, polished it up, and pressed publish on that story. Some did that more than once! Medium writers who participated in Draft Day published&nbsp;<a href=\"http://medium.com/tag/draft-day-2025\">over 500 drafts altogether.</a>&nbsp;We were joined by the editors of 24 publications who coached, encouraged, polished, and otherwise helped writers get their drafts over that publish finish line."
      }
    },
    {
      "id": "RUCU5gubfa",
      "type": "paragraph",
      "data": {
        "text": "Last month, 350 people joined&nbsp;<a href=\"https://blog.medium.com/draft-day-2025-live-blog-5d3f4d4b022b\">Draft Day 2025</a>&nbsp;in the live Zoom event, dug through their drafts folder on Medium, found a dusty draft, polished it up, and pressed publish on that story. Some did that more than once! Medium writers who participated in Draft Day published&nbsp;<a href=\"http://medium.com/tag/draft-day-2025\">over 500 drafts altogether.</a>&nbsp;We were joined by the editors of 24 publications who coached, encouraged, polished, and otherwise helped writers get their drafts over that publish finish line."
      }
    },
    {
      "id": "oDqtp4Su8t",
      "type": "paragraph",
      "data": {
        "text": "The energy on Draft Day was electric, despite the fact that most of the event took place in a quiet Zoom Room where we were just heads-down, working on our writing. Every so often, someone would announce a draft had been sent off to its readers, and we’d all cheer that writer on, akin to someone crossing the finish line after a long, hard race."
      }
    },
    {
      "id": "to3py-Bort",
      "type": "paragraph",
      "data": {
        "text": "<mark><code class=\"inline-code\">Those 350 Draft Day participants got something done that many people only ever dream of: they overcame their fears, got over procrastination, and shared their story with the world.</code></mark>"
      }
    },
    {
      "id": "pLbSMo4PU3",
      "type": "paragraph",
      "data": {
        "text": "Together, we wrote about&nbsp;<a href=\"https://medium.com/runners-life/twenty-two-more-lessons-i-wish-i-knew-when-i-started-running-42-years-ago-d9137cf0eb2c?sk=v2%2F4fdd0076-ec05-49c5-a422-7498d4e3a602\">lessons from 42 years of running</a>, experiencing temples and shrines in the&nbsp;<a href=\"https://medium.com/gardening-birding-and-outdoor-adventure/experiencing-nikko-without-translation-07bc8e5098e5?sk=v2%2F1e7924f4-0285-474d-be9d-6822d6c38e26\">forest of Nikko</a>, the&nbsp;<a href=\"https://medium.com/@cassiebegins/maybe-caregiving-is-beautiful-92774e2616d2\">beauty in caregiving</a>, the joy of&nbsp;<a href=\"https://medium.com/math-games/i-saw-this-math-puzzle-at-a-chinese-restaurant-in-prague-7f74f7cda6a3?sk=v2%2F5be38329-b542-4c1a-8614-461ccd000bb3\">solving math problems to get WiFi passwords</a>, and, naturally,&nbsp;<a href=\"https://medium.com/the-introvert-sayings/i-didnt-become-a-writer-life-made-me-one-7426f441031d?sk=v2%2F89d8495f-5f53-470c-ac66-c9efc9ad03ad\">what makes one become a writer</a>&nbsp;among many, many other topics. (Thank you to&nbsp;<a href=\"https://medium.com/u/5adc61f8677a?source=post_page---user_mention--3fe5de742c51---------------------------------------\" target=\"_blank\">Normi Coto, PhD</a>,&nbsp;<a href=\"https://medium.com/u/f71139cba9ad?source=post_page---user_mention--3fe5de742c51---------------------------------------\" target=\"_blank\">Pratibha Singh</a>,&nbsp;<a href=\"https://medium.com/u/5b43586cce64?source=post_page---user_mention--3fe5de742c51---------------------------------------\" target=\"_blank\">Cassie McDaniel</a>,&nbsp;<a href=\"https://medium.com/u/317d2c36c3c2?source=post_page---user_mention--3fe5de742c51---------------------------------------\" target=\"_blank\">BL</a>, and&nbsp;<mark><a href=\"https://medium.com/u/7d670a2ff57f?source=post_page---user_mention--3fe5de742c51---------------------------------------\" target=\"_blank\">Rubi Joshi</a></mark>&nbsp;respectively!)"
      }
    },
    {
      "id": "2NFGfXqspb",
      "type": "paragraph",
      "data": {
        "text": "Outside the event, we weren’t alone. Almost 30,000 people published their first story on Medium in April. Close to 100,000 writers overall published one or more stories on Medium last month."
      }
    },
    {
      "id": "_OFwA7W7Zm",
      "type": "paragraph",
      "data": {
        "text": "And if you’re feeling that itch? You’ve got the seed of an idea, but something’s holding you back? Head on over to&nbsp;<a href=\"http://story.new/\" target=\"_blank\">story.new</a>&nbsp;and start typing. Everyone’s got a story to tell, and only you can tell yours."
      }
    },
    {
      "id": "MIKEj4FEeq",
      "type": "paragraph",
      "data": {
        "text": "—&nbsp;<a href=\"https://medium.com/u/a870c0c34e46?source=post_page---user_mention--3fe5de742c51---------------------------------------\" target=\"_blank\">Zulie @ Medium</a>"
      }
    },
    {
      "id": "q3Nd2NNin7",
      "type": "header",
      "data": {
        "text": "By the numbers",
        "level": 3
      }
    },
    {
      "id": "mMfVFVPXoY",
      "type": "paragraph",
      "data": {
        "text": "In a snapshot, here’s what readers, writers, and editors did on Medium in April 2025:"
      }
    },
    {
      "id": "jX4Oah9LAS",
      "type": "list",
      "data": {
        "style": "unordered",
        "meta": {},
        "items": [
          {
            "content": "9+ million: How many times Medium readers clicked on their Daily or Weekly digest",
            "meta": {},
            "items": []
          },
          {
            "content": "53k: How many stories were submitted to Medium publications",
            "meta": {},
            "items": []
          },
          {
            "content": "10,000+: How many readers clapped for the ten most popular stories on Medium",
            "meta": {},
            "items": []
          }
        ]
      }
    },
    {
      "id": "7GMGUpbcCH",
      "type": "header",
      "data": {
        "text": "Dispatches from the people who were there",
        "level": 1
      }
    },
    {
      "id": "K7uxWFdGgy",
      "type": "paragraph",
      "data": {
        "text": "<mark>We all read the news, but some people&nbsp;</mark><mark>live</mark><mark>&nbsp;the news.</mark>&nbsp;They either experience an event first-hand that the rest of us only hear about, or they have a personal or professional window into it that the rest of us don’t have."
      }
    },
    {
      "id": "3EHOSC5vJT",
      "type": "paragraph",
      "data": {
        "text": "Some of those folks come to Medium to share their perspective on what’s going on. Want a deeper insight into a few of those headlines? Read on."
      }
    },
    {
      "id": "23rdMWCzld",
      "type": "list",
      "data": {
        "style": "unordered",
        "meta": {},
        "items": [
          {
            "content": "What Pope Francis was really like, from one-time staffer&nbsp;Daniel B. Gallagher",
            "meta": {},
            "items": []
          },
          {
            "content": "Tens of millions of people lost power in Spain and Portugal on April 28th.&nbsp;Charlie Brown&nbsp;was there when it happened",
            "meta": {},
            "items": []
          },
          {
            "content": "Lawyer&nbsp;John Polonis&nbsp;talks about&nbsp;the need to investigate the possible insider trading&nbsp;that occurred just before President Trump’s sweeping tariffs announcement",
            "meta": {},
            "items": []
          }
        ]
      }
    }
  ],
  "version": "2.31.0-rc.7"
}

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
    content: post_content.to_json,
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
