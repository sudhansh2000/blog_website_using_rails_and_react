import React from 'react'
import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'
import { useAuth } from "../contexts/AuthContext";

const UserPosts = ({id}) => {
  const { token } = useAuth();
  const [posts, setPosts] = useState([])
  useEffect(() => {
    axios.get(`${import.meta.env.VITE_API_BASE_URL}/v1/users/${id}/posts`)
      .then(res => setPosts(res.data))
      .catch(err => console.log(err));
  }, [id])



  const deletePost = (postId) => {
    // debugger;
    axios.delete(`${import.meta.env.VITE_API_BASE_URL}/v1/posts/${postId}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    .then(() => {
      alert("Post deleted successfully!")
      setPosts(posts.filter(post => post.id !== postId))
    })
    .catch(err => console.log(err))
  }
    
  return (
    <div>
      <h1 className="header">All Posts</h1>
      <div className="posts-list">
        {posts.map((post) => (
          <div key={post.id} className="post-card">
          <Link to={`/posts/${post.id}`} className="post-link">
            <h2>{post.title}</h2>
          </Link>
          <p className="post-tags">
            {post.tags.map((tag) => (
              <span key={tag} className="tag">#{tag}</span>
            ))}
          </p>
          <p className="post-date">
            posted on : {new Date(post.created_at).toLocaleDateString()}
          </p>
          <div>
            <Link to={`/edit_post/${post.id}`} className="user-link">
              <span className="button-edit">Edit</span>
            </Link>
            <span>
              <button className="button-delete" onClick={() => deletePost(post.id)}>delete Post</button>
            </span>
          </div>
        </div>        
        ))}
      </div>
    </div>
  )
}

export default UserPosts
