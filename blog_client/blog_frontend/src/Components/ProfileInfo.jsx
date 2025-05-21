import React, { useEffect, useState } from "react";
import axios from "axios";
import "./ProfileInfo.css"; // Link to your CSS

function ProfileInfo({ id }) {
  // const [user, setUser] = useState(null);
  const [userInfo, setUserInfo] = useState(null);

  useEffect(() => {
    axios
      .get(`${import.meta.env.VITE_API_BASE_URL}/v1/users/${id}`)
      .then((res) => setUserInfo(res.data))
      .catch(() => alert("Failed to fetch profile."));
  }, [id]);

  if (!userInfo) return <p>profile not found</p>;

  return (
    <div className="profile-container">
      <img
        src={`https://i.pravatar.cc/150?u=${userInfo.id}`} // Fake avatar based on user ID
        alt="Profile"
        className="profile-avatar"
      />
      <div className="profile-details">
        <h2>{userInfo.first_name} {userInfo.last_name}</h2>
        <p><strong>Username:</strong> @{userInfo.user_name}</p>
        <p><strong>Email:</strong> {userInfo.email}</p>
        <p><strong>Date of Birth:</strong> {userInfo.dob}</p>
      </div>
    </div>
  );
}

export default ProfileInfo;
