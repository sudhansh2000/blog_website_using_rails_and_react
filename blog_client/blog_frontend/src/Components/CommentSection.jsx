import React, { useEffect } from 'react'
import { useState } from 'react'
import axios from 'axios'
import './CommentSection.css'
import { Link } from 'react-router-dom'
import { useNavigate } from 'react-router-dom'
import { ToastContainer, toast, Bounce } from 'react-toastify'
import likepnghollow from '../assets/likepost.png'
// import lokepngfilled from '../assets/likepostfilled.png'
import replycomment from '../assets/replycomment.png'

const CommentSection = ({id}) => {

  const redirect = useNavigate();
  const user = JSON.parse(localStorage.getItem('user'));  
  const token = localStorage.getItem('token');
  const [commentBody, setCommentBody] = useState({user_id:null, content: ""});
  // const [commentText, setCommentText] = useState(nil,nil );
  const [activeReplyId, setActiveReplyId] = useState(null);
  const [comments, setComments] = useState([])
  const [replies, setReplies] = useState({})
  const [replyText, setReplyText] = useState("");

  useEffect(() => {
    axios.get(`http://localhost:3001/v1/posts/${id}/comments`)
      .then((res) => setComments(res.data))
      .catch((err) => console.error("Error fetching comments:", err));

  }, [id]);

  const likeComment= async(paramComment)=>{
    if(!user) redirect ('/sign_up');
    try {
      const res = await axios.post(`http://localhost:3001/v1/comments/${paramComment.id}/likes?user_id=${user.id}`,
      { userId: user._id },{headers: { Authorization: `Bearer ${token}` } });
        if(res.data.id!=null) {
          toast.success('Comment liked successfully!', {
            position: "top-right",
            autoClose: 3000,
            theme: "light",
            transition: Bounce,
          });
        }
        else {
          toast.warn("Comment already liked!", {
            position: "top-right",
            autoClose: 3000,
            theme: "light",
            transition: Bounce,
          });
        }
    } catch (err) {
      console.log(err);
    }
  }

  const handleCommentSubmit = (e) => {
    e.preventDefault();
    if (!user) return alert("Please log in to comment.");
    axios.post(`http://localhost:3001/v1/posts/${id}/comments`, {comment: commentBody}, {headers: { Authorization: `Bearer ${token}` } })
    .then((res) => {
      setComments([...comments, { ...res.data.comment, user_name: user.user_name }]);
      setCommentBody({user_id: user.id, content: ""});
      toast.success('Comment posted successfully!', {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
      })
    .catch((err) => {
      console.error("Error posting comment:", err);
    });
  };

  const loadReplies = (commentId) => {
    if (replies[commentId]) return;
    axios.get(`http://localhost:3001/v1/comments/${commentId}/comments`)
      .then(res => setReplies(prev => ({ ...prev, [commentId]: res.data })))
      .catch(err => console.error("Error fetching replies:", err));
  };

  const handleReplySubmit = async (e, parentId) => {
    e.preventDefault();
    if (!user) return alert("Please log in to reply.");
    try {
      await axios.post(
        `http://localhost:3001/v1/comments/${parentId}/comments`,
        {
          content: replyText,
          user_id: user.id, // Include user ID
        },
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      
      toast.success('Comment posted successfully!', {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
      setReplyText("");
      setActiveReplyId(null);
      // Refresh replies for that comment

      loadReplies(parentId);
    } catch (err) {
      console.error("Error posting reply:", err);
    }
  };

  return (
    <div>
      <ToastContainer />
      {user ? (
        <form onSubmit={handleCommentSubmit} className="comment-form">
          <textarea
            value={commentBody.content}
            onChange={(e) => setCommentBody({ ...commentBody, content: e.target.value, user_id: user.id })}
            placeholder="Write your comment here..."
            required
          />
        <button type="submit">Post Comment</button>
        </form>
        ) : (
          <p><em>Please log in to comment.</em></p>
        )
      }
        <h2 className='mt-4'>Comments</h2>
        {comments.map(comment => (
          <div key={comment.id} className="comment">
            <Link to={`/user/${comment.user_id}`}>
              <p>
                <strong>@{comment.user_name}</strong> 
              </p>
            </Link>
            <p>{comment.content}</p>
            <div className="comment-meta">
              {new Date(comment.created_at).toLocaleDateString()}
              {comment.replies_count > 0 && (
                <button className="reply-button" onClick={() => loadReplies(comment.id)}>
                  View {comment.replies_count} replies
                </button>
              )}

              {user && (
                <button onClick={() => likeComment(comment)}>
                  {comment.likes_count}
                  <img className="comment-image-button" src={likepnghollow} alt="Like" />
                  </button>
              )}

              {user && (
                <button onClick={() => setActiveReplyId(comment.id)}>
                  <img className='comment-image-button' src={replycomment} alt="reply" />
                </button>
              )}

            {activeReplyId === comment.id && (
              <form onSubmit={(e) => handleReplySubmit(e, comment.id)} className="reply-form">
                <textarea
                  value={replyText}
                  onChange={(e) => setReplyText(e.target.value)}
                  placeholder="Write a reply"
                  required
                />
                <button type="submit">Post Reply</button>
              </form>
            )}
            </div>

            {replies[comment.id] && (
              <div className="replies">
                {replies[comment.id].map(reply => (
                  <div key={reply.id} className="reply">
                    <Link to={`/user/${reply.user_id}`}>
                      <p><strong>@{reply.user_name}</strong></p>
                    </Link>
                    <p>{reply.content}</p>
                    <p className="comment-meta">
                      {new Date(reply.created_at).toLocaleDateString()}

                      {user && (
                        <button className='reply-button' onClick={() => likeComment(reply)}>Like</button>
                      )}
                    </p>
                  </div>
                ))}
              </div>
            )}
          </div>
        ))}
      
    </div>
  )
}

export default CommentSection
