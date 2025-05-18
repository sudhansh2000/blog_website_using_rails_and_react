import React from "react";
import { useState, useEffect } from "react";
import axios from "axios";
import "./PostsComponent.css";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import likepnghollow from "../assets/likepost.png";
import likepngfilled from "../assets/likepostfilled.png";
import bookmarkhollow from "../assets/savepost.png";
import bookmarkfilled from "../assets/savepostfilled.png";
import sharepng from "../assets/sharepost.png";
import { ToastContainer, toast, Bounce } from "react-toastify";
import { useRef } from "react";

const PostComponent = ({ id }) => {
  // debugger
  const dialogRef = useRef(null);
  const [likes, setLikes] = useState(0);
  const [users, setUsers] = useState([]);
  const redirect = useNavigate();
  const [post, setPost] = useState(null);
  const user = JSON.parse(localStorage.getItem("user"));
  const [isUserPresent, setUserPresent] = useState(user ? true : false);
  const token = localStorage.getItem("token");
  // const [shareDialogOpen, setShareDialogOpen] = useState(false);
  const [receiverId, setReceiverId] = useState(null);
  const [likepng, setLikePng] = useState(likepnghollow);
  const [bookmarkpng, setBookmarkPng] = useState(bookmarkhollow);

  const HandleOpenDialog = () => {
    if (!user) {
      alert("Please log in to like the post.");
      redirect("/sign_in");
      return; // prevent further execution
    }
    dialogRef.current.showModal();
  };
  
  const HandleCloseDialog = () => {
    dialogRef.current.close();
  };
  // var likepng = likepnghollow

  useEffect(() => {
    axios
      .get(`http://localhost:3001/v1/posts/${id}/likes`)
      .then((res) => setLikes(res.data.total_likes))
      .catch((err) => console.error("Failed to fetch likes:", err));
  }, [id]);

  const fetchUserData = async () => {
    try {
      await axios
        .get(`http://localhost:3001/v1/users`)
        .then((res) => setUsers(res.data))
        .catch((err) => console.error("Failed to fetch users:", err));
    } catch (error) {
      console.error("Error fetching users:", error);
    }
  };

  useEffect(() => {
    if (isUserPresent) {
      fetchUserData();
      setUserPresent(false);
    }
  }, [isUserPresent]);

  useEffect(() => {
    axios
      .get(`http://localhost:3001/v1/posts/${id}`)
      .then((res) => setPost(res.data))
      .catch((err) => console.error("Failed to fetch post:", err));
  }, [id]);


  const BookmarkPost = async () => {
    setBookmarkPng(bookmarkfilled);
    if (!user) {
      alert("Please log in to bookmark the post.");
      redirect("/sign_in");
    }
    try {
      await axios.post(
        `http://localhost:3001/v1/users/${user.id}/bookmarks?post_id=${id}`,
        { postId: id },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      toast.success("Post saved successfully!", {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
    } catch (error) {
      toast.warn(error.response.data.error, {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
      // alert(error.response.data.error);
    }
  };

  const SharePost = async () => {
    if (!user) {
      alert("Please log in to share the post.");
      redirect("/sign_in");
    }
    try {
      await axios.post(
        `http://localhost:3001/v1/users/${user.id}/share_posts`,
        { post_id: id, receiver_id: receiverId },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      HandleCloseDialog();
      toast.success("Post shared successfully!", {
        position: "top-right",
        autoClose: 3000,
        theme: "light",
        transition: Bounce,
      });
    } catch (error) {
      alert(error.response.data.error);
    }
  };

  const LikePost = async () => {
    setLikePng(likepngfilled);
    try {
      if (!user) {
        alert("Please log in to like the post.");
        redirect("/sign_in");
        return; // prevent further execution
      }

      const response = await axios.post(
        `http://localhost:3001/v1/posts/${id}/likes?user_id=${user.id}`,
        { user_id: user.id },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      if (response.data.id != null) {
        toast.success("Post liked successfully!", {
          position: "top-right",
          autoClose: 3000,
          theme: "light",
          transition: Bounce,
        });
        setLikes(likes + 1);
      } else {
        toast.warn("Already liked this post!", {
          position: "top-right",
          autoClose: 3000,
          theme: "light",
          transition: Bounce,
        });
      }
    } catch (error) {
      toast.error(error.response?.data?.error || "Something went wrong");
    }
  };
  
  if (!post) {
    return <div>Loading...</div>;
  }
  return (
    <div>
      <ToastContainer />
      <div className="post-info">
        <h1 className="post-title">{post.title}</h1>
        <div className="post-meta">
          <Link to={`/user/${post.user_id}`} className="user-link">
            <span>
              By{" "}
              <strong>
                {post.first_name} {post.last_name}
              </strong>{" "}
              (@{post.user_name})
            </span>
          </Link>
          <span> | </span>
          <span>{new Date(post.created_at).toLocaleDateString()}</span>
          <span> | </span>
          <span className="category">{post.cat_name}</span>
          <span> | </span>
        </div>

        <div className="post-tags">
          {post.tags &&
            post.tags.map((tag) => (
              <span key={tag} className="tag">
                #{tag}
              </span>
            ))}
        </div>
        <div className="post-content" style={{ whiteSpace: "pre-line" }}>
          {post.content}
        </div>
        {/* <p>{post.content}
        <div className="post-content">{post.content}</div>
        </p> */}
        <div className="post-actions">
          <span>
            {likes}
            <button className="post-details-button" onClick={LikePost}>
              <img
                className="image-button"
                src={likepng}
                alt="alternateimage"
              />
            </button>
          </span>
          <button className="post-details-button" onClick={BookmarkPost}>
            <img
              className="image-button"
              src={bookmarkpng}
              alt="alternateimage"
            />
          </button>
          <button className="post-details-button" onClick={HandleOpenDialog}>
            <img className="image-button" src={sharepng} alt="alternateimage" />
          </button>
        </div>

        <dialog ref={dialogRef} className="dialog-container">
          <div className="dialog-box">
              <button className="button-close-dialog" onClick={HandleCloseDialog}>
                close
              </button>
              <h6>select user to share post</h6>
              {/* <p>select user to share post</p> */}
            <div className="dialog-content"></div>
            <div className="user-select">
              <select onChange={(e) => setReceiverId(e.target.value)}>
                <option value="" defaultValue>
                  Select a user
                </option>
                {users.map((user) => (
                  <option key={user.id} value={user.id}>
                    {user.user_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <button className="button-dialog" onClick={SharePost}>
                share post
              </button>
            </div>
          </div>
        </dialog>

      </div>
    </div>
  );
};

export default PostComponent;
