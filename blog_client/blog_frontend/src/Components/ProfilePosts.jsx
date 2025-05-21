import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import './ProfilePosts.css';

const PAGE_SIZE = 30;

const ProfilePosts = ({ id }) => {
  const [posts, setPosts] = useState([]);
  const [pageNo, setPageNo] = useState(1);
  const [hasMore, setHasMore] = useState(true);

  useEffect(() => {
    const url = id
      ? `${import.meta.env.VITE_API_BASE_URL}/v1/users/${id}/posts?page_no=${pageNo}&page_size=${PAGE_SIZE}`
      : `${import.meta.env.VITE_API_BASE_URL}/v1/posts?page_no=${pageNo}&page_size=${PAGE_SIZE}`;

    axios.get(url)
      .then(res => {
        setPosts(res.data);
        setHasMore(res.data.length === PAGE_SIZE);
      })
      .catch(err => {
        console.log(err);
      });
  }, [id, pageNo]);

  const handlePrevious = () => {
    if (pageNo > 1) {
      setPageNo(pageNo - 1);
    }
  };

  const handleNext = () => {
    if (hasMore) {
      setPageNo(pageNo + 1);
    }
  };

  return (
    <div>
      <h1 className="header">All Posts</h1>
      <div className="posts-list">
        {posts.map((post) => (
          <Link to={`/posts/${post.id}`} key={post.id} className="post-link">
            <div className="post-card">
              <h2>{post.title}</h2>
              <p className="post-tags">
                {post.tags.map((tag) => (
                  <span key={tag} className="tag">#{tag}</span>
                ))}
              </p>
              <p className="post-date">
                posted on : {new Date(post.created_at).toLocaleDateString()}
              </p>
            </div>
          </Link>
        ))}
      </div>

      <div className="pagination">
        <button onClick={handlePrevious} disabled={pageNo === 1}>Prev</button>
        <span>Page {pageNo}</span>
        <button onClick={handleNext} disabled={!hasMore}>Next</button>
      </div>

    </div>
  );
};

export default ProfilePosts;
