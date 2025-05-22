import React from 'react'
import { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import axios from 'axios'
import { useState } from 'react'
import './AdminPage.css'


const AdminPage = () => {
  const user = JSON.parse(localStorage.getItem('user'))
  const redirect = useNavigate();
  const [users, setUsers] = useState([])

  
  useEffect(() => {
    if(user && user.role !== 'admin') {
      redirect('/')
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user])

  useEffect(() => {
    axios.get(`${import.meta.env.VITE_API_BASE_URL}/v1/admin/users`, {
      headers: { Authorization: `Bearer ${localStorage.getItem('token')}` }
    })    
    .then(res => setUsers(res.data))
    .catch(err => console.log(err));
  }, [])

  const handleToggleActive = async (userId) => {
    try {
      const res = await axios.patch(`${import.meta.env.VITE_API_BASE_URL}/v1/admin/users/${userId}`, {}, {
        headers: { Authorization: `Bearer ${localStorage.getItem('token')}` }
      });
  
      // Update the user list locally
      const updatedUser = res.data.user;
      setUsers(prev =>
        prev.map(user => user.id === updatedUser.id ? updatedUser : user)
      );
    } catch (err) {
      console.error('Failed to toggle user status', err);
    }
  };
  
  return (
    <div>

      <h1 className='dashboard-title'>Admin Dashboard</h1>
    <div className='admin-page'>


      <div className="user-table-container">
        <table className="user-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Username</th>
              <th>Email</th>
              <th>Active</th>
              <th>Joined On</th>
              {/* <th>Created On</th> */}
            </tr>
          </thead>
          <tbody>
            {users.map(user => (
              <tr key={user.id}>
                <td>{user.id}</td>
                <td>{user.first_name} {user.last_name}</td>
                <td>{user.user_name}</td>
                <td>{user.email}</td>
                {/* <td>true</td> */}
                <td>
                <button onClick={() =>handleToggleActive(user.id)} style={{
                  backgroundColor: user.is_active ? '#ff8181' : '#16a34a',
                  color: 'white',
                  padding: '5px 10px',
                  borderRadius: '5px',
                  border: 'none',
                  cursor: 'pointer'
                }}>
                    {user.is_active ? 'Ban' : 'Unban'}
                    </button>
                </td>
                <td>{new Date(user.created_at).toLocaleDateString()}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

    </div>
    </div>
  )
}

export default AdminPage
