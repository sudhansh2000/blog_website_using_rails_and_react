import React from 'react';
import './Footer.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faTwitter,
  faInstagram,
  faLinkedinIn,
  faGithub,
} from '@fortawesome/free-brands-svg-icons';

const Footer = () => {
  return (
    <footer className="footer">
      <div className="container">
        <div className="row">
          <div className="footer-col">
            <h4>company</h4>
            <ul>
              <li><a href="./about_us">about us</a></li>
              <li><a href="./about_us">our services</a></li>
              <li><a href="./about_us">privacy policy</a></li>
              <li><a href="./about_us">affiliate program</a></li>
            </ul>
          </div>
          <div className="footer-col">
            <h4>get help</h4>
            <ul>
              <li><a href="">FAQ</a></li>
              <li><a href="#">Why us</a></li>
              <li><a href="#">returns</a></li>
            </ul>
          </div>
          <div className="footer-col">
            <h4>follow us</h4>
            <div className="social-links">
              <a href="https://github.com/sudhansh2000"><FontAwesomeIcon icon={faGithub} /></a>
              <a href="https://github.com/sudhansh2000"><FontAwesomeIcon icon={faTwitter} /></a>
              <a href="https://www.instagram.com/sudhanshjawale/"><FontAwesomeIcon icon={faInstagram} /></a>
              <a href="https://in.linkedin.com/in/sudhansh-jawale"><FontAwesomeIcon icon={faLinkedinIn} /></a>
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
