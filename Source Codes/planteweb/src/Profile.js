import React from 'react';
import './App.css';
import { useState, useEffect } from 'react';//react hooks we use
import { db, auth } from './firebase-config';
import { collection, getDocs, addDoc,  doc, deleteDoc, serverTimestamp,onSnapshot } from "firebase/firestore";
import {useParams} from 'react-router-dom';
import {
  onAuthStateChanged,
} from "firebase/auth";






function Profile() {


  //Check logged in or not-------------------------------------------------------------------
  const [userlogged, setUser] = useState({});
  console.log(userlogged);
  onAuthStateChanged(auth, (currentUser) => {
    setUser(currentUser);
  });
  //Check logged in or not-------------------------------------------------------------------










  const [newMessage, setMessage] = useState([]);
  const [newReciver, setReciver] = useState([]);
  //create user function
  const useersCollectionREf = collection(db, "replies");

  const createUser = async () => {
    await addDoc(useersCollectionREf, { message: newMessage, time: serverTimestamp(), sender:userlogged.email, reciver: newReciver });

  }








  let { itemid } = useParams();
  const [uploadinfo, setUploadImageInfo] = useState([]);
  const uploadsCollectionREf = collection(db, "uploads");
  const deleteUploads = async (id) => {
    const uploadedDoc = doc(db, "uploads", id);
    await deleteDoc(uploadedDoc);
  };

 






  ////////////-----------------------------------------------

  const messagesRef = collection(db, "replies");
  //const query = messagesRef.orderBy('time').limit(25);
  const [replyinfo, setreplyInfo] = useState([]);

  const [reply2info, setreply2Info] = useState([]);

 // const [messages] = useCollectionData(query, { idField: 'id' });











   ////////////-----------------------------------------------



   useEffect(() => {
    const getUploadimageInfo = async () => {
      const data = await getDocs(uploadsCollectionREf);
      // console.log(data);
      setUploadImageInfo(data.docs.map(((doc) => ({ ...doc.data(), id: doc.id }))))
    }
    getUploadimageInfo();



    const getreplies = async () => {
      const data = await getDocs(messagesRef);
      // console.log(data);
      setreplyInfo(data.docs.map(((doc) => ({ ...doc.data(), id: doc.id }))))
    }
    getreplies();




    onSnapshot(collection(db, "replies"), (snapshot) => {
      setreply2Info(snapshot.docs.map((doc)=>({...doc.data(), id: doc.id})))
    })
    console.log(reply2info);

  }, []);


















  return (

    <div className="App">
      <h1>Item Page</h1>

      {uploadinfo.map((up) => {
        var myTime = up.time;
        var foo = myTime.toString();

        if (up.id == itemid) {
          return (<div>
            <div class="row">

              <div class="col-sm-4">
                {""}
                <div class="card" >
                  <img src={up.downloadURL} alt="..."></img>
                  <div class="card-body">
                    <h5 class="card-title">{up.sender}</h5>
                    <p class="card-text">{up.message}</p>
                    <p class="card-text">{up.long}</p>
                    <p class="card-text">{up.lat}</p>
                    <p class="card-text"><small class="text-muted">time+{foo}</small></p>
                  </div>
                </div>

                <button type="button" class="btn btn-outline-danger"
                  onClick={() => {
                    deleteUploads(up.id);
                  }}
                >
                  {" "}
                  Delete Post
                </button>
              </div>
              <div class="col-sm-4">
                <h1>
                  comments


                  
                </h1>

              


{reply2info.map((replyy) => {
            return (<div>
              {""}
              <h5>
                {replyy.message}
              </h5>
              
            
            </div>)
          })}

              </div>

              <div class="col-sm-4">
                <h1>
                  Reply
                </h1>

                <input placeholder="Message" onChange={(event) => { setMessage(event.target.value); setReciver(up.sender); }} />
                <button onClick={createUser}>Create Reply</button>
              </div>
            </div>




          </div>








          )
        }



      }

      )



      }

      <div>
        <h1>

        </h1>

      </div>
     
     

    </div>

  );



}

export default Profile;
