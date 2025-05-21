import React from 'react'
import { useState } from 'react';
import axios from 'axios';
import { useAuth } from "../contexts/AuthContext";
import { useNavigate } from 'react-router-dom';
import './CreatePost.css';
import { ToastContainer, toast, Bounce } from 'react-toastify';
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
import { useEffect } from 'react';
import { useRef } from 'react';

const CreatePost = () => {
  const redirect = useNavigate();
  const { user, token } = useAuth();
  const [form, setForm] = useState({ title: "", content: "", category_id: "", tags: [], is_private: false });

  const [categories, setCategories] = useState([]);


  const ejInstance = useRef(null);
  // const [content , setContent] = useState(null);
  // const [data, setData] = useState(null);

  useEffect(() => {
    if (!ejInstance.current) {
      ejInstance.current = new EditorJS({
        holder : 'content-area',
        autofocus: true,
        readOnly: false,
        tools: {
          header: Header,
          image: {
            class: ImageTool,
            config: {
              endpoints: {
                byFile: `${import.meta.env.VITE_API_BASE_URL}/uploads/image`, // for file upload
                byUrl: `${import.meta.env.VITE_API_BASE_URL}/uploads/image_by_url` // for URL upload (optional)
              }
            }
          },
          list: List,
          // checklist: Checklist,
          quote: Quote,
          warning: Warning,
          marker: Marker,
          code: CodeTool,
          delimiter: Delimiter,
          inlineCode: InlineCode,
          linkTool: LinkTool,
          embed: Embed,
          table: Table
        },
        placeholder: 'Let`s write an awesome story!',
        /**
         * Internationalzation config
         */
      });

      ejInstance.current.isReady
        .then(() => {
          console.log("Editor.js is ready to work!");
        })
        .catch((reason) => {
          console.log(`Editor.js initialization failed: ${reason}`);
        });
    }
    // Clean up on unmount
    return () => {
      if (ejInstance.current && ejInstance.current.destroy) {
        ejInstance.current.destroy();
        ejInstance.current = null;
      }
    };
  }, []);
  useState(() => {
    axios.get(`${import.meta.env.VITE_API_BASE_URL}/v1/categories`)
    .then(res => setCategories(res.data))
    .catch(err => console.log(err));
  }, []);
  
  const handleSubmit = async (e) => {
    e.preventDefault(); // ✅ Move this to the top
  
    // Save content from Editor.js
    let outputData;
    try {
      outputData = await ejInstance.current.save();
      setForm((prev) => ({ ...prev, content: JSON.stringify(outputData) }));
    } catch (error) {
      console.error("Saving failed:", error);
      return alert("Failed to save content from editor.");
    }
  
    // Clean tags
    form.tags = form.tags.map(tag => tag.trim()).filter(tag => tag !== "");
  
    if (!user) {
      alert("Please log in to create the post.");
      return;
    }
  
    try {
      const res = await axios.post(
        `${import.meta.env.VITE_API_BASE_URL}/v1/users/${user.id}/posts`,
        { post: { ...form, content: JSON.stringify(outputData) } }, // ✅ Ensure editor content is included
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
  
      alert("Post created successfully!");
      redirect(`/posts/${res.data.post.id}`);
    } catch (error) {
      console.error("Post creation error:", error);
      toast.warn(error.response?.data?.error || "Something went wrong", {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
    }
  };
  

  return (
    <div>
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
          <div>

            <label htmlFor="content">Content</label>
            <div className='content-area'>
              <div id="content-area" />  {/* this is the editorjs area to write post content */}
            </div>

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
