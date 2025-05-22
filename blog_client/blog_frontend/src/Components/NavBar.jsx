
import { Link } from "react-router-dom";
import { useAuth } from "../contexts/AuthContext";
import "./NavBar.css";

function Navbar() {
  const { user, logout } = useAuth();

  return (
    <nav className="navbar">
      <Link to="/" className="logo m-2">MyBlog</Link>

      <div className="nav-links">
        {user ? (
          user.role === "admin" ? (
          <div>
            <Link to={"/manage_categories"} className="user-link">
              <span>Manage Categories</span>
            </Link>
            <span> | </span>
            <button onClick={logout} className="logout-btn">Logout</button>
            <span>       </span>
            <span>| </span>
            <Link to={`/admin_dashboard`} className="user-link">
            <span className="navbar-name m-6">Admin Dashboard</span>
            </Link>
          </div>


          ):(

            <>
            <Link to={"/create_post"} className="user-link">
              <span>Write Post</span>
            </Link>
            <span> | </span>
            <button onClick={logout} className="logout-btn">Logout</button>
            <span>       </span>
            <span>| </span>
            <Link to={`/dashboard`} className="user-link">
          <span className="navbar-name m-6">Hi, {user.first_name}</span>
            </Link>
          </>
          )
        ) : (
          <>
            <Link to="/sign_in">Login</Link>
            <Link to="/sign_up">Register</Link>
          </>
        )}
      </div>
    </nav>
  );
}

export default Navbar;
