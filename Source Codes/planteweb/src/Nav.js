import React from 'react';
import './App.css';
import {Link} from 'react-router-dom'
import {
  
  signOut,
} from "firebase/auth";
import {auth} from './firebase-config';
import { useNavigate } from 'react-router-dom';

function Nav() {
  let navigate = useNavigate();
  const logout = async () => {
    await signOut(auth);
    navigate(`/`);
  };

  return (
    

    
    <nav style={{ backgroundColor: `black`, position: `fixed`,top:'0',width:'100%',overflow:'hidden',zIndex:'2' }}>
      <h3>Plante</h3>
     
      <ul className='navLinks'>
        <Link class="nav-link" to="/"><li>Home</li></Link>
        <Link class="nav-link" to="/Solution"><li>Solution</li> </Link>
   
        <Link class="nav-link" to="/Chat"><li>Chat</li> </Link> 
        <Link class="nav-link" to="/about"><li>About</li> </Link>  
        
        <button type="button" class="btn btn-outline-success" onClick={logout}> Sign Out </button>
      </ul>
    </nav>
    
  );
}

export default Nav;
