import React from 'react'
import ProfileInfo from '../Components/ProfileInfo'
import UserSharePosts from '../Components/UserSharePosts'
import UserBookmarks from '../Components/UserBookmarks'
import UserPosts from '../Components/UserPosts'
import {useNavigate} from 'react-router-dom'
import UserComments from '../Components/ProfileComments'
import UserLikes from '../Components/ProfileLikes'
import './Dashboard.css'
const Dashboard = () => {
  const [activeTab, setActiveTab] = React.useState('my_posts')
  const redirect = useNavigate();
  // const { user ,navigate} = useAuth();
  const user = JSON.parse(localStorage.getItem('user'))
  const id = user?.id

  if (!user) {
    redirect("/sign_in")
  }
  // React.useEffect(() => {
  //   if (!user) {
  //     redirect("/sign_in")
  //   }
  // }, [user, redirect]);
  // debugger
  return (

    <div>
      <h1 className='dashboard-title'>Dashboard</h1>
      <ProfileInfo id={id} />
      <div className='tabs'>
        <span>
          <button onClick={() => setActiveTab('my_posts')} className='active-tab'>
            My Posts
          </button>
        </span>
        <span>
          <button onClick={() => setActiveTab('shared_posts')} className='active-tab'>
            Shared Posts
          </button>
        </span>
        <span>
          <button onClick={() => setActiveTab('bookmarks')} className='active-tab'>
            Bookmarks
          </button>
        </span>
        <span>
          <button onClick={() => setActiveTab('my_comments')} className='active-tab'>
            My Comments
          </button>
        </span>
        <span>
          <button onClick={() => setActiveTab('my_likes')} className='active-tab'>
            My Likes
          </button>
        </span>
      </div>

      {activeTab === 'my_posts' && <UserPosts id={id} />}
      {activeTab === 'shared_posts' && <UserSharePosts id={id} />}
      {activeTab === 'bookmarks' && <UserBookmarks id={id} />}
      {activeTab === 'my_comments' && <UserComments id={id} />}
      {activeTab === 'my_likes' && <UserLikes id={id} />}

    </div>
  )
}

export default Dashboard
