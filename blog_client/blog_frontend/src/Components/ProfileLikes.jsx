import React from 'react'
import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'
import './ProfileLikes.css'

const ProfileLikes = ({id}) => {
  const [likes, setLikes] = useState([])
  
  useEffect(() => {
    axios.get(`${import.meta.env.VITE_API_BASE_URL}/v1/users/${id}/likes`)
        .then(res =>  setLikes(res.data))
        .catch(err => console.log(err));
      },[id])

  return (
    <div>
      <h1 className="header">All Liked Posts</h1>
      <div className="posts-list">

        {likes.map((like) => (
          <Link to={`/posts/${like.id}`} key={like.id} className="post-link">
            <div className="post-card">
              <h2>{like.title}</h2>
              <p className="post-date">
                likes on : {new Date(like.created_at).toLocaleDateString()}
              </p>
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}

export default ProfileLikes
