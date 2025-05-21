import React from 'react'
import './SignUp.css'
import { Link } from 'react-router-dom'
import { useNavigate } from 'react-router-dom'
import axios from 'axios'
import { useState } from 'react'
// import 
const SignUp = () => {
  const navigate = useNavigate();
  const [form, setForm] = useState({ first_name: "",last_name: "", user_name: "", phone_number: "", email: "", password: "", dob: "" });

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post(
        `${import.meta.env.VITE_API_BASE_URL}/v1/users`,
        { user: form },
        {
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }
        }
      );
  
      alert("Account created successfully. Please select your preferred categories.");
      navigate("/select-categories", { state: { userId: response.data.user.id } });
  
    } catch (err) {
      alert(err.response?.data?.error || "Account creation failed.");
      console.error(err);
    }
  };
  // Helper to get today's date in YYYY-MM-DD format
  const today = new Date().toISOString().split('T')[0];

  return (
    <div>
      <div className="background-container">
      <div className="card">
        <div className="card_title">
          <h1>Create Account</h1>
          <span>Already have an account? <Link to={"/sign_in"}>Sign In</Link></span>
        </div>
        <div className="form">
        <form onSubmit={handleSubmit}>
          <span><input type='text' name="first_name" placeholder='First Name' onChange={handleChange} required></input></span>
          <span><input type='text' name="last_name" placeholder='Last Lame' onChange={handleChange} required></input></span>
          <input type="text" name="user_name" placeholder="User_name" onChange={handleChange} required />
          <input type="email" name="email" placeholder="Email" id="Email" onChange={handleChange} required />
          <input type="password" name="password" placeholder="Password" id="password" onChange={handleChange} required />
          <input type="tel" name="phone_number" placeholder="Phone Number" pattern="[0-9]{10}" maxLength={10} minLength={10} onChange={handleChange} required title="Please enter a 10-digit phone number"
          />
          {/* input date of birth */}
          <input type="date" name="dob" id="dob" placeholder="Date of Birth" onChange={handleChange} required max={today} />

          <button type='submit'>Sign Up</button>
          </form>
        </div>
        <div className="card_terms">
            <input type="checkbox" name="" id="terms" /> <span>I have read and agree to the <a href="">Terms of Service</a></span>
        </div>
      </div>
    </div>
    </div>
  )
}

export default SignUp
