import logo from './logo.svg';
import { useState, useEffect } from 'react';//react hooks we use
import './App.css';
//import { useState } from 'react';
import { db, auth } from './firebase-config';
import { collection, getDocs, addDoc, updateDoc, doc, deleteDoc, Timestamp,onSnapshot } from "firebase/firestore";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  onAuthStateChanged,
  signOut,
} from "firebase/auth";
import { Button,Alert} from 'bootstrap';
//import 'bootstrap/dist/css/bootstrap.min.css'
//import style from './stylemod.css'
import image from './images/loginsvg.svg';
import Blogs from "./ShowDetails";
import { Bar,Pie, defaults } from 'react-chartjs-2'



function App2() {

  const navstyleq = {
    color: "DodgerBlue",
    fontFamily: "Arial"
  
  };
  const mystylecontainer = {
    margin:"5%",
    fontFamily: "Arial"
     
    
  };
  
  const mystylebackground = {
   
    padding: "10px",
    fontFamily: "Arial"
    
    
  };

  const mystyle = {
    backgroundColor: "DodgerBlue",
    fontFamily: "Arial"
    
  };
//


var fb1=0,fb2=0,fb3=0,fb4=0,fb5=0,nullnum=0;


const BarChart = ({ chartData }) => {
  return (
    <div>
      <Bar
        data={chartData}
        options={{
          plugins: {
            title: {
              display: true,
              text: "Cryptocurrency prices"
            },
            legend: {
              display: true,
              position: "bottom"
           }
          }
        }}
      />
    </div>
  );
};







  // login related

  const [emailError, setEmailError] = useState("");
  const [passwordError, setPasswordError] = useState("");

  const [emailAddress, setemailAddress] = useState("");
  const [authPassword, setauthPassword] = useState("");
  const [hasAccount,setHasAccount]=useState(false);
  const [user, setUser] = useState({});

  onAuthStateChanged(auth, (currentUser) => {
    setUser(currentUser);
  });


  const clearErrors = () => {
    setEmailError('');
    setPasswordError('');
  }

  const register = async () => {
    clearErrors();
    try {
      const user = await createUserWithEmailAndPassword(
        auth,
        emailAddress,
        authPassword
      );
      console.log(user);
    } catch (error) {
      switch (error.code) {
        case "auth/invalid-email":
          setEmailError(error.message);
          break;
        case "auth/weak-password":
          setPasswordError(error.message);
          break;
      }

      console.log(error.message);
    }
  };

  const login = async () => {
    clearErrors();
    try {
      const user = await signInWithEmailAndPassword(
        auth,
        emailAddress,
        authPassword
      );
      console.log(user);
    } catch (error) {
      switch (error.code) {
        case "auth/invalid-email":
        case "auth/user-disabled":
        case "auth/user-not-found":
          setEmailError(error.message);
          break;
        case "auth/wrong-password":
          setPasswordError(error.message);
          break;
      }
      console.log(error.message);
    }
  };

  const logout = async () => {
    await signOut(auth);
  };


  /* this things need move to web page */

  const [feedbackinfo, setFeedbackInfo] = useState([]);
  const [uploadinfo, setUploadImageInfo] = useState([]);

  const feedbackCollectionREf = collection(db, "feedback")
  const uploadsCollectionREf = collection(db, "uploads")


  ///feedback

  const [reply2info, setreply2Info] = useState([]);
//------
  useEffect(() => {

    const getFeedbacks = async () => {
      const data = await getDocs(feedbackCollectionREf);
      // console.log(data);
      setFeedbackInfo(data.docs.map(((doc) => ({ ...doc.data(), id: doc.id }))))

    }
    getFeedbacks()
//feedback sbaps
    onSnapshot(collection(db, "feedback"), (snapshot) => {
      setreply2Info(snapshot.docs.map((doc)=>({...doc.data(), id: doc.id})))
    })
    console.log(reply2info);




    const getUploadimageInfo = async () => {
      const data = await getDocs(uploadsCollectionREf);
      // console.log(data);
      setUploadImageInfo(data.docs.map(((doc) => ({ ...doc.data(), id: doc.id }))))

    }
    getUploadimageInfo()




  }, [])
  return (
   
    <div className="App">


      {user ? (
        <section>
          
         

          

          <div><h1>
         
          </h1></div>
         


<div><h1>

             
{reply2info.map((fdb) => {
            
            if (fdb.feedback == 1) {
              ++fb1;
            } else if (fdb.feedback == 2) {
              ++fb2;
            }
            else if (fdb.feedback == 3) {
              ++fb3;
            }
            else if (fdb.feedback == 4) {
              ++fb4;
            }
            else if (fdb.feedback == 5) {
              ++fb5;
            }
            else if (fdb.feedback == null) {
              ++nullnum;
            }
             

            return (<div>
              {""}
              







             
            </div>)
          })}


     



          </h1>
         
          <h1>
          {fb1}
          </h1>
          <h1>
          {fb2}
          </h1>
          <h1>
          {fb3}
          </h1>
          <h1>
          {fb4}
          </h1>
          <h1>
          {fb5}
          </h1>
          
          
          
          </div>
          <div><h1>------------
          </h1>
          <h4>Welcome {user?.email} </h4>
          
          </div>


         
        </section>


      ) : (
        <section style={mystylebackground}>
          
          <div class="container" style={mystylecontainer}>
          <div class="row content">
          <div class="col-md-6 mb-3">
         
          <img src={image} class="img-fluid" alt="Responsive image"></img>
            </div>
            <div class="col-md-6">
          <div >
          <div class="form-group">
          <label for="email">Email</label>
          
          <input class="form-control"
            placeholder="email"
            onChange={(event) => {
              setemailAddress(event.target.value);
            }}
                    
          />
            <h1>{emailError}</h1>
        </div>

        <div class="form-group">
          <label for="password">Password</label>
         
         < input class="form-control"
            placeholder="password" type="password"
            onChange={(event) => {
              setauthPassword(event.target.value);
            }}
            
          />
          <h1>{passwordError}</h1>
        </div>


         
          <div className='buttonContainer'>
          {hasAccount?(
          <>
          <button onClick={register} type="button" class="btn btn-outline-success"> sign up</button>
          <p>
            Don't have an account?
            <span onClick={()=>setHasAccount(false)}>Signup</span>
          </p>
          </>
          ):(
            <>
            <button onClick={login} type="button" class="btn btn-outline-success">sign in</button>
          <p>
            have an account?
            <span onClick={()=>setHasAccount(true)}>Signup</span>
          </p>
          </>
          )}
          </div>
          </div>
          </div>
          </div>
          </div>

        </section>
      )}

 
      
    </div>

    
  );

}

export default App2;


