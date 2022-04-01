import React from 'react';
import './App.css';
import {Link} from 'react-router-dom'

function Nav() {
  return (
    <nav>
      <h3>Logo</h3>
      <ul className='navLinks'>
        <Link to="/about"><li>About</li> </Link>
        <Link to="/Solution"><li>Solution</li> </Link>
        <Link to="/"><li>Home</li></Link>
        
      </ul>
    </nav>
  );
}

export default Nav;
