import './App.css'
import NavBar from './Components/NavBar'
import Footer from './Components/Footer'
import 'react-toastify/dist/ReactToastify.css';
// import { ToastContainer, toast } from 'react-toastify';
import { Routes, Route } from 'react-router-dom'
// import Card from './Componts/Card'
import Home from './Pages/Home'
import PostDeatil from './Pages/PostDetail'
import SignIn from './Pages/SignIn'
import SignUp from './Pages/SignUp'
import  UserProfile from './Pages/UserProfile'
import CreatePost from './Pages/CreatePost'
import Dashboard from './Pages/Dashboard'
import EditPost from './Pages/EditPost'
import AboutUs from './Pages/AboutUs'
import PreferredCategories from './Pages/PreferredCategories';

function App() {
  return (
    <>
    <NavBar/>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/posts/:id" element={<PostDeatil />}/>
        <Route path="/sign_in" element={<SignIn />}/>
        <Route path="/sign_up" element={<SignUp />}/>
        <Route path="/user/:id" element={<UserProfile />}/>
        <Route path="/create_post" element={<CreatePost />}/>
        <Route path="/dashboard" element={<Dashboard />}/>
        <Route path="/edit_post" element={<Dashboard />}/>
        <Route path="/edit_post/:id" element={<EditPost />} />
        <Route path="/about_us" element={<AboutUs />} />
        <Route path="/select-categories" element={<PreferredCategories />} />
        {/* <Route path="/posts" element={<Posts />} /> */}
      </Routes>
      <Footer/>
    </>
  )
}

export default App
