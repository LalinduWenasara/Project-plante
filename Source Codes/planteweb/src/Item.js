import React from 'react';
import { useLocation } from "react-router"
import './App.css';
import { useState, useEffect } from 'react';//react hooks we use
import { db, auth } from './firebase-config';
import { collection, getDocs, addDoc, updateDoc, doc, deleteDoc, Timestamp } from "firebase/firestore";
import {useNavigate,useParams} from 'react-router-dom';


function Item() {
  let {itemid} =useParams();
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



  return (
 
    <div className="App">
      <h1>Item Page</h1>
      {uploadinfo.map((up) => {
            var myTime =up.time;
            var foo = myTime.toString();
        
            if(up.id==itemid){
            return (<div><div class="col-sm-4">
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
             
              <button type="button" class="btn btn-outline-success"
                onClick={() => {
                  deleteUploads(up.id);
                }}
              >
                {" "}
                Delete Post
              </button>
            </div>
        <div>
          <h1>testt</h1>
        </div>
</div>

      






            )}
        

        
          }
        
          )
        
        
        
          }




    </div>
  );



}

export default Item;
