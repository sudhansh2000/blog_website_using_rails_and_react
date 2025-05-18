import React from 'react'
import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'


const UserBookmarks = ({id}) => {

  const [posts, setPosts] = useState([])
  
  useEffect(() => {
    axios.get(`http://localhost:3001/v1/users/${id}/bookmarks`)
        .then(res =>  setPosts(res.data))
        .catch(err => console.log(err));
      },[id])

  return (
    <div>

      <h1 className="header">Bookmarks</h1>
      <div className="posts-list">
        {/* {posts.map(post =>console.log(post))} */}

        {posts.map((post) => (
          <Link to={`/posts/${post.id}`} key={post.id} className="post-link">
            <div className="post-card">
              <h2>{post.title}</h2>
              <p className="post-date">
                bookmarked on : {new Date(post.created_at).toLocaleDateString()}
              </p>
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}

export default UserBookmarks
