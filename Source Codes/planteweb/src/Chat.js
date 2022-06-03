import React from 'react';
import './App.css';
import { useState, useEffect } from 'react';//react hooks we use
import { db, auth } from './firebase-config';
import { collection, getDocs, addDoc, doc, deleteDoc, serverTimestamp, onSnapshot, query, orderBy } from "firebase/firestore";
import { useNavigate } from 'react-router-dom';
import {
  onAuthStateChanged,
} from "firebase/auth";
import Swal from 'sweetalert2';





function Chat() {
  let navigate = useNavigate();


  const messageRight = {


    borderRadious: "10px",
    alignItems: 'right',
    TextAlign: 'right'

  };
  const messageleft = {


    borderRadious: "10px",
    TextAlign: 'left',
    backgroundColor: '#e6ffe6'
  };


  const userslist = {


    borderRadious: "10px",
    alignItems: 'right',
    TextAlign: 'right',
    backgroundColor: `#99ff99`,
  };













  const [messagetext, setmessagetext] = useState([]);


  const [uploadinfo, setUploadImageInfo] = useState([]);
  const [userprofile, setuserprofile] = useState([]);


  useEffect(() => {

    onSnapshot(collection(db, "messages"), orderBy('time', 'desc'), (snapshot) => {
      setUploadImageInfo(snapshot.docs.map((doc) => ({ ...doc.data(), id: doc.id })))
    })
    onSnapshot(collection(db, "userprofile"), (snapshot) => {
      setuserprofile(snapshot.docs.map((doc) => ({ ...doc.data(), id: doc.id })))
    })



  }, []);


  //Check logged in or not-------------------------------------------------------------------
  const [user, setUser] = useState({});

  onAuthStateChanged(auth, (currentUser) => {
    setUser(currentUser);
  });
  //Check logged in or not-------------------------------------------------------------------



  const [newMessage, setMessage] = useState([]);


  /*
  const fruits = [];
  //fruits.push("Kiwi");


  const uniqueNames = Array.from(new Set(fruits));
  console.log("this is it")
  //console.log(uniqueNames);

*/





  const useersCollectionREf = collection(db, "messages");

  const createReply = async () => {
    if (newMessage != "") {
      await addDoc(useersCollectionREf, { text: newMessage, time: serverTimestamp(), sender: user.email, reciver: "test" });
      //window.location.reload(false);

    }
    else {
      console.log("enter msg");


    }
  }


























  if (user !== null)
    return (



      <div className="App">
        <div class="clearfix" style={{ backgroundColor: `#f8fcf9`, marginTop: '5%' }}>
          <h1>Chat</h1>


          <div class="container">

            <div class="row">
              <div class="col-4" >



                {userprofile.map((uprofile) => {
                   return (
                    <div class="row">
                      
                      <div class="col">
                        <div class="card" style={userslist}>
                          {""}
                          <div class="card" >
                            <div class="card-body" style={userslist}>
                              <h5 class="card-title">{uprofile.displayName}</h5>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  )




                //  fruits.push("hh");


                }

                )



                }


























              </div>



              <div class="col-8" style={{ overflowY: `scroll` }}>
                {uploadinfo.map((up) => {

                  var myTime = up.time;
                  console.log(uploadinfo);



                  if (up.sender == user.email) {
                    return (
                      <div class="row">
                        <div class="col">
                        </div>
                        <div class="col">
                          <div class="card" style={messageRight}>
                            {""}
                            <div class="card" >
                              <div class="card-body">
                                <h5 class="card-title">{up.text}</h5>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    )
                  }
                  else {
                    return (
                      <div class="row">
                        <div class="col">
                          <div class="card" >
                            {""}
                            <div class="card" >
                              <div class="card-body" style={messageleft} >
                                <h5 class="card-title">{up.text}</h5>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="col">
                        </div>
                      </div>

                    )
                  }

                }

                )



                }
              </div>











              <div class="clearfix" style={{ backgroundColor: `black`, position: `fixed`, bottom: '0', padding: '0.2%', paddingLeft: '20%', borderRadius: '8px', width: '80%' }}>

                <div class="">
                  <input placeholder="Message" onChange={(event) => {

                    setMessage(event.target.value);

                  }} /> <button onClick={() => {
                    //  deleteUploads(up.id);
                    createReply();
                    //  

                  }



                  }
                    type="button" class="btn btn-outline-success">Send</button>
                </div>
                <div >





                </div>









              </div>

            </div>




          </div>


























        </div>
      </div>



    )






      ;




  return (
    <div className="App">
      <h1> plase login</h1>
    </div>
  );





}

export default Chat;
