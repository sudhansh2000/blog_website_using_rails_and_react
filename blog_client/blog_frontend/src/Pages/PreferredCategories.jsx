import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './PreferredCategories.css'; // optional for styling
import { useLocation, useNavigate } from 'react-router-dom';

const PreferredCategories = () => {

  const location = useLocation();
  const navigate = useNavigate();
  const userId = location.state?.userId;

  const [categories, setCategories] = useState([]);
  const [selectedIds, setSelectedIds] = useState([]);
  const [loading, setLoading] = useState(true);

  console.log(userId);
  useEffect(() => {
    // Fetch categories from API
    axios.get('http://localhost:3001/v1/categories')
      .then(response => {
        setCategories(response.data);
        setLoading(false);
      })
      .catch(error => {
        console.error("Error fetching categories:", error);
        setLoading(false);
      });
  }, []);

  const handleCheckboxChange = (id) => {
    setSelectedIds(prev =>
      prev.includes(id) ? prev.filter(i => i !== id) : [...prev, id]
    );
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post(`http://localhost:3001/v1/users/${userId}/category_preferences`, {
        category_preference: { ids: selectedIds }
      });
      alert('Preferences saved!');
      navigate('/'); // or dashboard, home etc.
    } catch (error) {
      console.error('Error saving preferences:', error);
      alert('Failed to save preferences.');
    }
  };

  if (loading) return <p>Loading categories...</p>;

  return (
    <div className="preferred-categories-container">
      <h2>Select Your Preferred Categories</h2>
      <form onSubmit={handleSubmit}>
        <div className="categories-list">
          {categories.map(category => (
            <label key={category.id} className="category-item">
              <input
                type="checkbox"
                value={category.id}
                checked={selectedIds.includes(category.id)}
                onChange={() => handleCheckboxChange(category.id)}
              />
              {category.cat_name}
            </label>
          ))}
        </div>
        <button type="submit" className="submit-btn">Save Preferences</button>
      </form>
    </div>
  );
};

export default PreferredCategories;
