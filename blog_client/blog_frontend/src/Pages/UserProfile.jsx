
import React, { useState } from 'react'
import './UserProfile.css'
import { useParams } from 'react-router-dom'
import ProfilePosts from '../Components/ProfilePosts'
import ProfileComments from '../Components/ProfileComments'
import ProfileLikes from '../Components/ProfileLikes'
import ProfileInfo from '../Components/ProfileInfo'

const UserProfile = () => {
  const id = useParams().id
  const [activeTab, setActiveTab] = useState('posts')

  return (
    <div>
      <ProfileInfo id={id} />
      <div className='tabs'>
        <span>
          <button
            onClick={() => setActiveTab('posts')}
            className='active-tab'
          >
            Posts
          </button>
        </span>
        <span>
          <button
            onClick={() => setActiveTab('comments')}
            className='active-tab'
          >
            Comments
          </button>
        </span>
        <span>
          <button
            onClick={() => setActiveTab('likes')}
            className='active-tab'
          >
            Likes
          </button>
        </span>
      </div>

      {activeTab === 'posts' && <ProfilePosts id={id} />}
      {activeTab === 'comments' && <ProfileComments id={id} />}
      {activeTab === 'likes' && <ProfileLikes id={id} />}
    </div>
  )
}

export default UserProfile