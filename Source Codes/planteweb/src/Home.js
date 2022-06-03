import logo from './logo.svg';
import { useState, useEffect } from 'react';//react hooks we use
import './App.css';
//import { useState } from 'react';
import { db, auth } from './firebase-config';
import { collection, getDocs, addDoc, updateDoc, doc, deleteDoc, Timestamp, onSnapshot } from "firebase/firestore";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  onAuthStateChanged,
  signOut,
} from "firebase/auth";
import { Button, Alert } from 'bootstrap';
//import 'bootstrap/dist/css/bootstrap.min.css'
//import style from './stylemod.css'
import image from './images/loginsvg.svg';
import Blogs from "./ShowDetails";
import React from "react";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
} from "chart.js";
import { Bar } from "react-chartjs-2";
import { useNavigate } from 'react-router-dom';
import image2 from './images/plant-diseases.jpg';


ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
);

export const options = {
  responsive: true,
  plugins: {
    title: {
      display: true,
      text: "Feed Back"
    }
  }
};

const labels = ["very_dissatisfied", "dissatisfied", "neutral", "satisfied", "very_satisfied"];



/*
export const data = {
  labels,
  datasets: [
    {
      label: "Dataset 1",
      data: ([4, 9, 16, 25,5]),
      backgroundColor: "rgba(255, 99, 132, 0.5)"
    },
  ]
};
*/




function App2() {

  const navstyleq = {
    color: "DodgerBlue",
    fontFamily: "Arial"

  };
  const mystylecontainer = {
    margin: "5%",
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

  const homestyle = {
    backgroundColor: `#f8fcf9`,
    marginTop:'5%'


  };


  const welcomestyle = {

    height: "500px",
    fontFamily: "Arial",
    fontSize: "150%",

  };

  const container1style = {

    height: "200px",
    fontFamily: "Arial"

  };
  const containerimgstyle = {

    
    fontFamily: "Arial",
    width:"100%",
    optically:"0.1"
  };






  //


  var fb1 = 0, fb2 = 0, fb3 = 0, fb4 = 0, fb5 = 0, nullnum = 0;
  var solutioncount = 0;
  let navigate = useNavigate();



  // login related

  const [emailError, setEmailError] = useState("");
  const [passwordError, setPasswordError] = useState("");
  const [emailAddress, setemailAddress] = useState("");
  const [authPassword, setauthPassword] = useState("");
  const [hasAccount, setHasAccount] = useState(false);
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

  const [plantPathologistinfo, plantPathologistInfo] = useState([]);
  const plantPathologistCollectionREf = collection(db, "PlantPathologist");
  ///feedback

  const [reply2info, setreply2Info] = useState([]);


  const [solutionuploadsInfo, setsolutionuploadsInfo] = useState([]);
  //------
  useEffect(() => {
    /*
        const getFeedbacks = async () => {
          const data = await getDocs(feedbackCollectionREf);
          // console.log(data);
          setFeedbackInfo(data.docs.map(((doc) => ({ ...doc.data(), id: doc.id }))))
    
        }
        getFeedbacks()*/
    //feedback sbaps
    onSnapshot(collection(db, "feedback"), (snapshot) => {
      setreply2Info(snapshot.docs.map((doc) => ({ ...doc.data(), id: doc.id })))
    })
    console.log(reply2info);



    const getUploadimageInfo = async () => {
      const data = await getDocs(uploadsCollectionREf);
      // console.log(data);
      setUploadImageInfo(data.docs.map(((doc) => ({ ...doc.data(), id: doc.id }))))

    }
    getUploadimageInfo()



    onSnapshot(collection(db, "PlantPathologist"), (snapshot) => {
      plantPathologistInfo(snapshot.docs.map((doc) => ({ ...doc.data(), id: doc.id })))
    })
    console.log(plantPathologistinfo);



    onSnapshot(collection(db, "uploads"), (snapshot) => {
      setsolutionuploadsInfo(snapshot.docs.map((doc) => ({ ...doc.data(), id: doc.id })))
    })
    console.log(plantPathologistinfo);



  }, [])
  return (

    <div className="App">


      {user ? (
        <section style={homestyle}>

          <div><h1>

          </h1></div>



          <div><h1>


            {solutionuploadsInfo.map((solutionupload) => {/* if (solutionupload.time == 1) { ++fb1;}*/solutioncount++;}  ) }

            {reply2info.map((fdb) => {if (fdb.feedback == 1) {++fb1;} else if (fdb.feedback == 2) { ++fb2;}else if (fdb.feedback == 3) { ++fb3;}else if (fdb.feedback == 4) {++fb4;}else if (fdb.feedback == 5) {++fb5;}else if (fdb.feedback == null) { ++nullnum;}  } )}






          </h1>
          <div class="container" style={container1style}>
  
</div>
            {plantPathologistinfo.map((userinf) => {
              if (userinf.emailAddress == user?.email)
                return (<div style={welcomestyle}>
                  {""}
                  <h3 style={welcomestyle}>Welcome   &nbsp;&nbsp;
                    {userinf.firstname} &nbsp;{userinf.Lastname} <br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;you have &nbsp;{solutioncount} detections today
                  </h3>


                </div>)
            })}
            <img src={image2} class="img-fluid" alt="Responsive image" style={containerimgstyle}></img>
            <div class="container" style={container1style}>
  </div>
            <div class="container-sm">
              <Bar options={options} data={{
                labels,
                datasets: [
                  {
                    label: "Feedback",
                    data: ([fb1, fb2, fb3, fb4, fb5]),
                    backgroundColor: "rgba(92, 284, 116, 0.5)",
                    hoverBackgroundColor: "green",

                  },
                ]

              }} />
            </div>


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
                    {hasAccount ? (
                      <>

                        <button onClick={register} type="button" class="btn btn-outline-success"> sign up</button>
                        <p>
                          Don't have an account?
                          <span onClick={() => setHasAccount(false)}>Sigip</span>
                        </p>
                      </>
                    ) : (
                      <>
                        <button onClick={login} type="button" class="btn btn-outline-success">sign in</button>
                        <p>
                          have an account?
                          <span onClick={() => navigate(`/signuppage`)}>Signup</span>
                        </p>
                      </>
                      /* 
                      ()=>navigate(`/signuppage`)
                      
                      onClick={() => {
                          navigate(`/item/${up.id}`);
            
                        }*/
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


