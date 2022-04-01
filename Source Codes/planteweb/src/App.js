import logo from './logo.svg';
import { useState, useEffect } from 'react';//react hooks we use
import './App.css';
import Nav from './Nav'
import About from './About';
import Solution from './Solution';
import App2 from './Home';
import {BrowserRouter, Route, Routes ,NavLink} from 'react-router-dom';
import {auth} from './firebase-config';
import {
  onAuthStateChanged,
} from "firebase/auth";
import Item from './Item';
import ErrorPage from './ErrorPage';

function App() {

  const [user, setUser] = useState({});

  onAuthStateChanged(auth, (currentUser) => {
    setUser(currentUser);
  });


  return (
    <BrowserRouter>
    <div className="App">
    {user ? (
      <Nav/>):(<h1></h1>)}
      <Routes>
        <Route path="/" exact element={<App2 />} />
        <Route path="/about" element={<About />} />
        <Route path="/solution" element={<Solution />} />
        <Route path="/item/:itemid" element={<Item />} />
        <Route path="*" element={<ErrorPage />} />
        </Routes>
    </div>
    </BrowserRouter>
  );
}

export default App;
