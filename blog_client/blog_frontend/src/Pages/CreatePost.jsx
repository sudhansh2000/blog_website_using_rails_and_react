import React from 'react'
import { useState } from 'react';
import axios from 'axios';
import { useAuth } from "../contexts/AuthContext";
import { useNavigate } from 'react-router-dom';
import './CreatePost.css';
import { ToastContainer, toast, Bounce } from 'react-toastify';

const CreatePost = () => {
  const redirect = useNavigate();
  const { user, token } = useAuth();
  const [form, setForm] = useState({ title: "", content: "", category_id: "", tags: [], is_private: false });

  const [categories, setCategories] = useState([]);


  useState(() => {
    axios.get("http://localhost:3001/v1/categories")
    .then(res => setCategories(res.data))
    .catch(err => console.log(err));
  }, []);
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    form.tags = form.tags.map(tag => tag.trim()).filter(tag => tag !== "");
    if (!user) return alert("Please log in to create the post.");
    try {
      const res = await axios.post(`http://localhost:3001/v1/users/${user.id}/posts`, 
        { post: form },
        {headers: { Authorization: `Bearer ${token}` }
    } );
    alert("Post created successfully!");
    redirect(`/posts/${res.data.post.id}`);
    }
    catch (error) {
      toast.warn(error.response.data.error, {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
      alert(error.response.data.errors);
    }
  }

  return (
    <div className='background-container'>
      <div className="form-container">
      <h1 >Create Post</h1>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="title">Title</label>
            <input type="text" id="title" 
              placeholder='Enter your title' 
              value={form.title} onChange={(e) => setForm({ ...form, title: e.target.value })} required
            />
          </div>
      <ToastContainer />
          <div className="form-group">
            <label htmlFor="content">Content</label>
            <textarea id="content" 
              placeholder='Write whats on your mind' 
              value={form.content} 
              onChange={(e) => setForm({ ...form, content: e.target.value })} required
            ></textarea>
          </div>
          <div className="category_menu">
            <label htmlFor="category_id">Category</label>
            <select id="category_id" required value={form.category_id} onChange={(e) => setForm({ ...form, category_id: e.target.value })}>
            <option value="" disabled>
              Select a category
            </option>
              {categories.map(category => (
                <option key={category.id} value={category.id}>{category.cat_name} </option>
              ))}
            </select>
          </div>
          <div className="form-group">
            <label htmlFor="tags">Tags</label>
            <input type="text" 
            placeholder='Enter tags separated by comma'
              id="tags" value={form.tags} 
              onChange={(e) => setForm({ ...form, tags: e.target.value.trim().split(",") })} 
            />  
          </div>
          <div className="form-group">
            <label htmlFor="is_private">Private</label>
            <input type="checkbox" 
              id="is_private" 
              checked={form.is_private} 
              onChange={(e) => setForm({ ...form, is_private: e.target.checked })} 
            />
          </div>
          <button type="submit">Create Post</button>
        </form>
      </div>
      
    </div>
  )
}

export default CreatePost;
