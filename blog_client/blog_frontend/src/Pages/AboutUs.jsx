import React from 'react';
import './AboutUs.css';

const AboutUs = () => {
  return (
    <div className="about-us-container">
      <div className="about-us-header">
        <h1>About Us</h1>
      </div>
      
      <div className="about-us-content">
        <p>
          Welcome to our Blog Management System! This platform has been designed to provide users with an intuitive and seamless blogging experience. 
          Whether you're a beginner looking to start your blogging journey or an experienced writer, our system has everything you need to manage your content efficiently.
        </p>

        <h2>Our Project</h2>
        <p>
          This project is a combination of modern technologies and robust frameworks. The backend of the system is built using **Ruby on Rails**, 
          a powerful and secure framework that ensures reliability and scalability. 
        </p>

        <p>
          For the frontend, we’ve utilized **React** to build an interactive and dynamic user interface. The React components ensure that users 
          have a smooth and responsive experience as they navigate through the platform.
        </p>

        <h2>Why Choose Us?</h2>
        <p>
          Our goal is to make blogging easy, efficient, and enjoyable. By using Rails for the backend, we ensure that all your data is processed 
          securely and quickly. React’s reactive user interface helps users to focus on content creation without worrying about performance or user experience.
        </p>
        
        <p>
          Whether you're managing a single blog or running multiple blogs, our platform is designed to meet your needs. We believe that 
          technology should empower content creators, not hinder them. With our Blog Management System, we’ve created an environment that 
          fosters creativity and productivity.
        </p>

        <h2>Get In Touch</h2>
        <p>
          If you have any questions, suggestions, or feedback, feel free to reach out to us. We’re always open to improving the system and providing the best experience for our users.
        </p>
        
        <p>
          Thank you for choosing our platform — we look forward to seeing the amazing content you create!
        </p>
      </div>
    </div>
  );
};

export default AboutUs;
