// import React, { useState, useEffect } from 'react'
import PostComponent from '../Components/PostsComponent'
import { useParams } from "react-router-dom";
import CommentSection from '../Components/CommentSection';

const PostDetail = () => {
  const { id } = useParams();

  return (
    <div >
      <div className="post-detail">
        <PostComponent id={id}/>
      </div>

      <div className='comments-section'>
        <CommentSection id={id}/>
      </div>
      
    </div>
  )
}

export default PostDetail
