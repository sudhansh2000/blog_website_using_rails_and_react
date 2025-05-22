import React, { useEffect, useState } from 'react';
import axios from 'axios';
// import './AdminManageCategories.css';
import { ToastContainer, toast, Bounce } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import "./ManageCategories.css"

const ManageCategories = () => {
  const [categories, setCategories] = useState([]);
  const [newCategoryName, setNewCategoryName] = useState('');
  const [loading, setLoading] = useState(true);

  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchCategories();
  }, []);

  const fetchCategories = async () => {
    try {
      const res = await axios.get(`${import.meta.env.VITE_API_BASE_URL}/v1/categories`);
      setCategories(res.data);
      setLoading(false);
    } catch (err) {
      console.error('Error fetching categories:', err);
      setLoading(false);
    }
  };

  const handleCreateCategory = async (e) => {
    e.preventDefault();
    if (!newCategoryName.trim()) return;

    try {
      await axios.post(
        `${import.meta.env.VITE_API_BASE_URL}/v1/categories`,
        { category: { cat_name: newCategoryName } },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      toast.success("Category created!", {
        position: "top-right",  
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
      setNewCategoryName('');
      fetchCategories(); // refresh list
    } catch (err) {
      console.error('Error creating category:', err);
      const errorMessage = Array.isArray(err.response?.data?.error)
        ? err.response.data.error.join(', ')
        : err.response?.data?.error || 'Category creation failed.';
      toast.error(errorMessage, {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
    }
  };

  const handleDeleteCategory = async (id) => {
    if (!window.confirm('Are you sure you want to delete this category?')) return;

    try {
      await axios.delete(
        `${import.meta.env.VITE_API_BASE_URL}/v1/categories/${id}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      toast.success("Category deleted", {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
      setCategories(prev => prev.filter(cat => cat.id !== id));
    } catch (err) {
      console.error('Error deleting category:', err);
      toast.error("Failed to delete category", {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
    }
  };

  if (loading) return <p>Loading categories...</p>;

  return (
    <div className="admin-categories-container">
      <ToastContainer />
      <h2>Manage Categories</h2>

      <form onSubmit={handleCreateCategory} className="create-category-form">
        <input
          type="text"
          value={newCategoryName}
          onChange={(e) => setNewCategoryName(e.target.value)}
          placeholder="New category name"
          required
        />
        <button type="submit">Add Category</button>
      </form>

      <ul className="categories-list">
        {categories.map(cat => (
          <li key={cat.id} className="category-item">
            {cat.cat_name}
            <button onClick={() => handleDeleteCategory(cat.id)}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default ManageCategories;
