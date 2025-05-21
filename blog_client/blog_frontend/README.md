# Blog Website Frontend - React

This is the React frontend for the Blog Website application. It provides the user interface for interacting with the blog/social media style platform, including user authentication, post creation, commenting, liking, bookmarking, sharing posts, and managing category preferences.

## Technologies Used

- React 19.1.0
- React Router DOM for client-side routing
- Axios for HTTP requests to the backend API
- Editor.js and related plugins for rich text editing in posts
- FontAwesome for icons
- React Toastify for notifications
- Vite as the build tool and development server
- Tailwind CSS for utility-first styling
- ESLint for code linting

## Features

- User registration, login, and authentication with context management
- Create, edit, and delete blog posts with rich text content
- Comment on posts and reply to comments
- Like and bookmark posts
- Share posts with other users
- Manage preferred categories for personalized content
- Responsive and user-friendly UI with Bootstrap and Tailwind CSS
- Client-side routing with React Router

## Setup and Installation

### Prerequisites

- Node.js (v16 or higher recommended)
- npm (comes with Node.js)

### Installation Steps

1. Clone the repository and navigate to the frontend directory:

   ```bash
   git clone <repository-url>
   cd blog_frontend
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Start the development server:

   ```bash
   npm run dev
   ```

4. Open your browser and navigate to:

   ```
   http://localhost:5173
   ```

   The app will automatically reload if you make edits.

## Connecting to Backend API

The frontend communicates with the Ruby on Rails backend API to perform authentication and CRUD operations on posts, comments, likes, bookmarks, and categories. Ensure the backend server is running (default port 3001) and accessible to the frontend.

## Project Structure

- `src/` - Main source code directory
  - `components/` - Reusable UI components (e.g., Navbar, PostsComponent, CommentSection)
  - `contexts/` - React context providers (e.g., AuthContext for authentication state)
  - `pages/` - Page components corresponding to routes (e.g., Home, SignIn, SignUp, CreatePost)
  - `assets/` - Static assets like images and icons
  - `App.jsx` - Main app component with route definitions
  - `main.jsx` - React app entry point

## Routing

Client-side routing is handled by React Router DOM. The app uses `BrowserRouter` to manage navigation between pages such as Home, Post Detail, User Profile, Sign In, and Sign Up.

## Styling

The app uses a combination of Bootstrap 5 and Tailwind CSS for styling. Custom CSS files are used for component-specific styles.

## Testing and Linting

- To lint the codebase, run:

  ```bash
  npm run lint
  ```

- No automated tests are currently included in the frontend.

## Deployment

The app can be built for production using:

```bash
npm run build
```

This generates optimized static files in the `dist/` directory, which can be served by any static file server or integrated with the backend.

## Additional Notes

- Authentication state is managed using React Context (`AuthContext`).
- Rich text editing in posts is implemented using Editor.js and its plugins.
- Notifications are handled with React Toastify.
- Axios is used for all HTTP requests to the backend API.
- Ensure CORS is properly configured on the backend to allow requests from the frontend origin.
