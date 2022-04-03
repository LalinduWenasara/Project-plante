import React from 'react';
import './App.css';
import {Link} from 'react-router-dom'
import {
  
  signOut,
} from "firebase/auth";
import {auth} from './firebase-config';

function Nav() {
  const logout = async () => {
    await signOut(auth);
  };

  return (
    <nav>
      <h3>Plante</h3>
     
      <ul className='navLinks'>
        <Link to="/"><li>Home</li></Link>
        <Link to="/Solution"><li>Solution</li> </Link>
        <Link to="/about"><li>About</li> </Link>
        
       
        <button type="button" class="btn btn-outline-success" onClick={logout}> Sign Out </button>
      </ul>
    </nav>
  );
}

export default Nav;
