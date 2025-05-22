import { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../contexts/AuthContext";
import "./SignUp.css";
import { Link } from "react-router-dom";
function SignIn() {
  const { login } = useAuth();
  const navigate = useNavigate();
  const [form, setForm] = useState({ email: "", password: "" });

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post(`${import.meta.env.VITE_API_BASE_URL}/sign_in`, { user: form });
      login(res.data.user, res.data.token);
      if (res.data.user.role === "admin") {
        navigate("/admin_dashboard");
      } else {
        navigate("/");
      }
        
    // eslint-disable-next-line no-unused-vars
    } catch (err) {
      alert("Login failed.");
    }
  };

  return (
    <div>
      <div className="background-container">
      <div className="card">
        <div className="card_title">
          <h1>Login Account</h1>
          <span>Dont have an account? <Link to={"/sign_up"}>Sign up</Link></span>
        </div>
        <div className="form">
        <form onSubmit={handleSubmit}>
        <h2>Sign In</h2>
          <input name="email" type="email" placeholder="Email" onChange={handleChange} required />
          <input name="password" type="password" placeholder="Password" onChange={handleChange} required />
          <button type="submit">Login</button>
          </form>
        </div>
        <div className="card_terms">
            <input type="checkbox" name="" id="terms" /> <span>I have read and agree to the <a href="">Terms of Service</a></span>
        </div>
      </div>
    </div>
    </div>
  );
}

export default SignIn;
