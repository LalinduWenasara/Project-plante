import React from 'react';
import './App.css';
import { useState, useEffect } from 'react';//react hooks we use
import { db, auth } from './firebase-config';
import { collection, getDocs,doc, deleteDoc, Timestamp } from "firebase/firestore";
import { useNavigate } from 'react-router-dom';
import {
  onAuthStateChanged,
} from "firebase/auth";






function Solution() {
  let navigate = useNavigate();



  const stylecard = {
    
    width:"20%",

  
  };

  const stylecardimg = {
    
    
    height: "400px",
    objectFit: "cover",
    borderRadious:"10px",
 

  
  };






  const [uploadinfo, setUploadImageInfo] = useState([]);
  const uploadsCollectionREf = collection(db, "uploads");
  const deleteUploads = async (id) => {
    const uploadedDoc = doc(db, "uploads", id);
    await deleteDoc(uploadedDoc);
  };

  

  useEffect(() => {

    const getUploadimageInfo = async () => {
      const data = await getDocs(uploadsCollectionREf);
      // console.log(data);
      setUploadImageInfo(data.docs.map(((doc) => ({ ...doc.data(), id: doc.id }))))

    }
    getUploadimageInfo()



  }, []);


  //Check logged in or not-------------------------------------------------------------------
  const [user, setUser] = useState({});

  onAuthStateChanged(auth, (currentUser) => {
    setUser(currentUser);
  });
  //Check logged in or not-------------------------------------------------------------------


  if(user !==null)
  return (


    
    <div className="App">
    <div class="clearfix" style={    {backgroundColor: `#f8fcf9`,}}>
      <h1>Solution Page</h1>

      

      
   
      <div class="row row-cols-auto">
{uploadinfo.map((up) => {

var myTime = up.time;
console.log(uploadinfo);
console.log("id is " + up.id);
var foo = myTime.toDate().toString();


return (

<div class="card" style={stylecard}>
          {""}
          <div class="card" >
            <img style={stylecardimg} src={up.downloadURL} alt="..."></img>
            <div class="card-body">
              <h5 class="card-title">{up.sender}</h5>
              <p class="card-text">{up.message}</p>
              <p class="card-text"><small class="text-muted">{foo}</small></p>
            </div>
          </div>
          <button type="button" class="btn btn-outline-success"
            onClick={() => {
              navigate(`/item/${up.id}`);

            }}
          >
            {" "}
            See details
          </button>


        </div>

      

        )
   




}

)



}
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

export default Solution;
