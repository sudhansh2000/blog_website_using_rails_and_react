import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useAuth } from "../contexts/AuthContext";
import { useNavigate, useParams } from 'react-router-dom';
import './CreatePost.css'; // Reuse same styles

const EditPost = () => {
  const redirect = useNavigate();
  const { id } = useParams(); // post ID from URL
  const { token } = useAuth();
  const [form, setForm] = useState({ title: "", content: "", category_id: "", tags: [], is_private: false });
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);

  // Fetch categories and the post to edit
  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const catRes = await axios.get("http://localhost:3001/v1/categories");
        setCategories(catRes.data);
      } catch (err) {
        console.error("Error fetching categories:", err);
      }
    };

    fetchCategories();
  }, []);

  useEffect(() => {
    const fetchPost = async () => {
      try {
        const postRes = await axios.get(`http://localhost:3001/v1/posts/${id}`, {
          headers: { Authorization: `Bearer ${token}` }
        });
        const fetchedPost = postRes.data;
        setForm(prevForm => ({
          ...prevForm,
          title: fetchedPost.title,
          content: fetchedPost.content,
          category_id: categories.find(cat => cat.cat_name === fetchedPost.cat_name)?.id || "",
          tags: fetchedPost.tags,
          is_private: fetchedPost.is_private,
        }));
        setLoading(false);
      } catch (err) {
        console.error("Error fetching post:", err);
      }
    };

    if (categories.length > 0) {
      fetchPost();
    }
  }, [id, token, categories]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    form.tags = form.tags.map(tag => tag.trim()).filter(tag => tag !== "");
    try {
      await axios.patch(`http://localhost:3001/v1/posts/${id}`,
        { post: form },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      alert("Post updated successfully!");
      redirect(`/posts/${id}`);
    } catch (error) {
      console.error("Error updating post:", error);
    }
  };

  const handleChange = (field, value) => {
    setForm({ ...form, [field]: value });
  };

  if (loading) return <p>Loading post...</p>;

  return (
    <div className='background-container'>
      <div className="form-container">
        <h1>Edit Post</h1>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="title">Title</label>
            <input type="text" id="title"
              value={form.title}
              onChange={(e) => handleChange("title", e.target.value)}
              required />
          </div>

          <div className="form-group">
            <label htmlFor="content">Content</label>
            <textarea id="content"
              value={form.content}
              onChange={(e) => handleChange("content", e.target.value)} />
          </div>

          <div className="category_menu">
            <label htmlFor="category_id">Category</label>
            <select
              id="category_id"
              value={form.category_id}
              onChange={(e) => handleChange("category_id", e.target.value)}
              required
            >
              <option value="" disabled>Select a category</option>
              {categories.map(category => (
                <option key={category.id} value={category.id}>{category.cat_name}</option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label htmlFor="tags">Tags</label>
            <input type="text"
              id="tags"
              value={form.tags.join(", ")}
              onChange={(e) => handleChange("tags", e.target.value.split(","))}
              placeholder="Separate tags with commas" />
          </div>

          <div className="form-group">
            <label htmlFor="is_private">Private</label>
            <input
              type="checkbox"
              id="is_private"
              checked={form.is_private}
              onChange={(e) => handleChange("is_private", e.target.checked)} />
          </div>

          <button type="submit">Update Post</button>
        </form>
      </div>
    </div>
  );
};

export default EditPost;
