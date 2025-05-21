import React from 'react'
import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'

const ProfileComments = ({id}) => {
  const [comments, setComments] = useState([])
  
  useEffect(() => {
    axios.get(`${import.meta.env.VITE_API_BASE_URL}/v1/users/${id}/comments`)
        .then(res =>  setComments(res.data))
        .catch(err => console.log(err));
      },[id])

  return (
    <div>
      <h1 className="header">All Comments</h1>
      <div className="posts-list">
        {/* {posts.map(post =>console.log(post))} */}

        {comments.map((comment) => (
          <Link to={`/posts/${comment.post_id}`} key={comment.id} className="post-link">
            <div className="post-card">
              <h2>{comment.title}</h2>
              <p className="post-paragraph">{comment.content}</p>
              <p className="post-date">
                commented on : {new Date(comment.created_at).toLocaleDateString()}
              </p>
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}

export default ProfileComments
