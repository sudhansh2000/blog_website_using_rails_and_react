import React from 'react'
import { Link } from 'react-router-dom'

const Card = () => {
  return (
    <div>
      <Link to="#">
        <div className="card" style={{ width: '18rem' }}>
          <img className="card-img-top" src="..." alt="Card image cap" />
          <div className="card-body">
            <h5 className="card-title">Card title</h5>
            <p className="card-text">
              Some quick example text to build on the card title and make up the bulk of the card's content.
            </p>
            <span className="btn btn-primary">Go somewhere</span>
          </div>
        </div>
      </Link>
    </div>
  )
}

export default Card
