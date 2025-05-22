This project is a full-stack blog and social media style application with a Ruby on Rails backend API and a React frontend.

Backend (Ruby on Rails):

Provides a RESTful API for user authentication, post creation, commenting, liking, bookmarking, sharing posts, and category management.
Uses Ruby on Rails 8.0.2 with SQLite3 database and Puma web server.
Authentication is handled with Devise and JWT tokens.
Supports nested resources for user-specific posts, comments, likes, bookmarks, and category preferences.
Includes image upload support for rich content.
Uses Hotwire (Turbo and Stimulus) for frontend interactivity and Jbuilder for JSON responses.
Testing is done with RSpec.
API endpoints cover authentication, posts, comments, categories, bookmarks, shared posts, and image uploads.
Frontend (React):

React 19.1.0 frontend providing the user interface for the blog platform.
Features user registration, login, and authentication state management with React Context.
Allows creating, editing, and deleting blog posts with rich text content using Editor.js.
Supports commenting, replying to comments, liking, bookmarking, and sharing posts.
Manages preferred categories for personalized content.
Uses React Router DOM for client-side routing and Axios for API communication.
Styled with and Bootstrap, with responsive and user-friendly UI.
Notifications handled with React Toastify.
Built and served using Vite development server.
