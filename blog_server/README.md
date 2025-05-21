# Blog Website Using Ruby on Rails

This is a Ruby on Rails API backend for a blog/social media style application. It provides user authentication, post creation, commenting, liking, bookmarking, sharing posts, and category management features.

## Technologies Used

- Ruby on Rails 8.0.2
- SQLite3 database
- Puma web server
- Devise and Devise-JWT for authentication
- Hotwire (Turbo and Stimulus) for frontend interactivity
- Importmap for JavaScript management
- Jbuilder for JSON API responses
- RSpec for testing
- Docker for containerization

## Features

- User registration, login, and authentication with JWT
- CRUD operations for posts, comments, likes, bookmarks, categories, and shared posts
- Nested resources for user-specific posts, comments, likes, bookmarks, and category preferences
- Image upload support
- Health check endpoint

## Setup and Installation

### Prerequisites

- Ruby 3.x (compatible with Rails 8)
- SQLite3
- Node.js and Yarn (optional, if using frontend assets)
- Docker (optional, for containerized deployment)

### Installation Steps

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd blog_server
   ```

2. Install Ruby gems:

   ```bash
   bundle install
   ```

3. Set up the database:

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the Rails server:

   ```bash
   rails s

   ```

   The server will run on port on `http://localhost:3001`.

## API Endpoints Overview

- Authentication:
  - `POST /sign_in` - User login
  - `DELETE /sign_out` - User logout
  - Devise handles user registration and authentication with JSON responses.

- User-related resources (under `/v1/users`):
  - Posts, bookmarks, share posts, category preferences, comments, likes

- Posts (`/v1/posts`):
  - CRUD operations with nested comments and likes

- Comments (`/v1/comments`):
  - CRUD operations with nested comments and likes

- Categories (`/v1/categories`):
  - Manage categories and their posts

- Bookmarks (`/v1/bookmarks`):
  - Manage bookmarks

- Share Posts (`/v1/share_posts`):
  - Manage shared posts

- Image Upload for frontend editor.js:
  - `POST /uploads/image`


## Running Tests

This project uses RSpec for testing.

Run the test suite with:

```bash
bundle exec rspec
```

## Deployment

This application can be deployed using Docker. A `Dockerfile` and `bin/kamal` deployment tool are included for containerized deployment.

## Additional Notes

- CORS is configured via `rack-cors`.
- Authentication uses JWT tokens via `devise-jwt`.
- The app uses Hotwire (Turbo and Stimulus) for frontend interactivity.
- For development, debugging tools like `web-console` and `debug` gem are included.
