import React from 'react'
import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'

const UserSharePosts = ({id}) => {
  const [posts, setPosts] = useState([])
  
  useEffect(() => {
    axios.get(`http://localhost:3001/v1/users/${id}/share_posts`)
        .then(res =>  setPosts(res.data))
        .catch(err => console.log(err));
      },[id])


  return (
    <div>
      <h1 className="header">Shared Posts</h1>
      <div className="posts-list">
        {posts.map((post) => (
          <div>
            <div className="post-card">
          <Link to={`/posts/${post.post_id}`} key={post.post_id} className="post-link">
              <h2>{post.title}</h2>
          </Link>
              <Link to={`/user/${post.user_id}`} className="user-link">
                <p className="post-date mx-auto">shared by : {post.user_name}</p>
              </Link>
              <p className="post-date">
                shared on : {new Date(post.created_at).toLocaleDateString()}
              </p>

            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

export default UserSharePosts
