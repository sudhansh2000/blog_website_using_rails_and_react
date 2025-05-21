import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useAuth } from "../contexts/AuthContext";
import { useNavigate, useParams } from 'react-router-dom';
import './CreatePost.css'; // Reuse same styles
import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';
// import Checklist from '@editorjs/checklist';
import Quote from '@editorjs/quote';
import Warning from '@editorjs/warning';
import Marker from '@editorjs/marker';
import CodeTool from '@editorjs/code';
import Delimiter from '@editorjs/delimiter';
import InlineCode from '@editorjs/inline-code';
import LinkTool from '@editorjs/link';
import Embed from '@editorjs/embed';
import Table from '@editorjs/table';
// import SimpleImage from '@editorjs/simple-image';
import ImageTool from '@editorjs/image';
import { useRef } from 'react';

const EditPost = () => {
  const redirect = useNavigate();
  const { id } = useParams(); // post ID from URL
  const { token } = useAuth();
  const [form, setForm] = useState({ title: "", content: "", category_id: "", tags: [], is_private: false });
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);

  const ejInstance = useRef(null);
  // const [content , setContent] = useState(null);
  // const [data, setData] = useState(null);

  useEffect(() => {
  }, []);
  
  // Fetch categories and the post to edit
  
  useEffect(() => {
    const fetchPost = async () => {
      try {
        const postRes = await axios.get(`${import.meta.env.VITE_API_BASE_URL}/v1/posts/${id}`, {
          headers: { Authorization: `Bearer ${token}` }
        });
        const fetchedPost = postRes.data;
        setForm(prevForm => ({
          ...prevForm,
          title: fetchedPost.title,
          content: JSON.parse(fetchedPost.content),
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

  useEffect(() => {
    if (form.content && !ejInstance.current) {
      ejInstance.current = new EditorJS({
        holder: 'content-area',
        autofocus: true,
        readOnly: false,
        // data: JSON.parse(form.content), // Now it's loaded!
        data: form.content, // Now it's loaded!
        tools: {
          header: Header,
          image: {
            class: ImageTool,
            config: {
              endpoints: {
                byFile: `${import.meta.env.VITE_API_BASE_URL}/uploads/image`,
                byUrl: `${import.meta.env.VITE_API_BASE_URL}/uploads/image_by_url`
              }
            }
          },
          list: List,
          quote: Quote,
          warning: Warning,
          marker: Marker,
          code: CodeTool,
          delimiter: Delimiter,
          inlineCode: InlineCode,
          // linkTool: LinkTool,
          embed: Embed,
          table: Table
        },
        placeholder: 'Let`s write an awesome story!',
      });
  
      ejInstance.current.isReady
        .then(() => {
          console.log("Editor.js is ready with content!");
        })
        .catch((reason) => {
          console.error("Editor.js initialization failed:", reason);
        });
    }

    return () => {
      if (ejInstance.current && ejInstance.current.destroy) {
        ejInstance.current.destroy();
        ejInstance.current = null;
      }
    };
  }, [form.content]); // <-- wait for content
  
  
  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const catRes = await axios.get(`${import.meta.env.VITE_API_BASE_URL}/v1/categories`);
        setCategories(catRes.data);
      } catch (err) {
        console.error("Error fetching categories:", err);
      }
    };

    fetchCategories();
  }, []);



  const handleSubmit = async (e) => {
    e.preventDefault();

    let outputData;
    try {
      outputData = await ejInstance.current.save();
      setForm((prev) => ({ ...prev, content: outputData }));
    } catch (error) {
      console.error("Saving failed:", error);
      return alert("Failed to save content from editor.");
    }
  
    let payload = {...form, content: JSON.stringify(outputData)}

    payload.tags = payload.tags.map(tag => tag.trim()).filter(tag => tag !== "");

    try {
      await axios.patch(`${import.meta.env.VITE_API_BASE_URL}/v1/posts/${id}`,
        { post: payload },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      alert("Post updated successfully!");
      redirect(`/posts/${id}`);
    } catch (error) {
      console.error("Error updating post:", error);
    }
  };

  console.log(form)

  const handleChange = (field, value) => {
    setForm({ ...form, [field]: value });
  };

  if (loading) return <p>Loading post...</p>;

  return (
    <div>
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
            <div className='content-area'>
              <div id="content-area" />  {/* this is the editorjs area to write post content */}
            </div>
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
