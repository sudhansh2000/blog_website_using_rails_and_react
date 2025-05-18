// import React, { useEffect, useState } from 'react'
// import axios from 'axios'
// import { Link } from 'react-router-dom'
import ProfilePosts from '../Components/ProfilePosts'
import './Home.css'

const Home = () => {
  // const [posts, setPosts] = useState([])
  
  // useEffect(() => {
  //   axios.get(`http://localhost:3001/v1/posts`)
  //       .then(res =>  setPosts(res.data))
  //       .catch(err => console.log(err));
  //   },[])

  return (
    <div >
      <ProfilePosts/>
    </div>
  )
}

export default Home
