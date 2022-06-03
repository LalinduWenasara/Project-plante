import React from 'react';
import './App.css';
import { useState, useEffect } from 'react';//react hooks we use
import { db, auth } from './firebase-config';
import { collection, getDocs, addDoc, doc, deleteDoc, serverTimestamp, onSnapshot, query, orderBy } from "firebase/firestore";
import { useNavigate, useParams } from 'react-router-dom';
import {

  onAuthStateChanged,

} from "firebase/auth";
import {
  GoogleMap,
  useLoadScript,
  Marker,
  InfoWindow,
} from "@react-google-maps/api";
import Swal from 'sweetalert2';

const libraries = ["places"];
const mapContainerStyle = {
  width: '500px',
  height: '500px'
};
const center = {
  lat: 43.6532,
  lng: -79.3832,
};











function Item() {

  let { itemid } = useParams();
  let navigate = useNavigate();



  //Check logged in or not-------------------------------------------------------------------
  const [userlogged, setUser] = useState({});
  console.log(userlogged);
  onAuthStateChanged(auth, (currentUser) => {
    setUser(currentUser);
  });
  //Check logged in or not-------------------------------------------------------------------


  /*
  
  function getWeatherFromApiAsync(x,y) {
    var mylink='https://api.openweathermap.org/data/2.5/onecall?lat='+x+'&lon='+y+'&exclude=hourly,daily&appid=a32e9315ac8c2587b4313752a387651a'
    return fetch(mylink)
    .then((response) => response.json())
    .then((responseJson) => {
     return responseJson;
      //setWeatherData(responseJson);
    
    })
    .catch((error) => {
      console.error(error);
    });
 }   */






  //https://api.openweathermap.org/data/2.5/onecall?lat=6.8213291&lon=80.0415729&exclude=hourly,daily&appid=c49d22e6566a98cf13ef8904065a6193
  //a32e9315ac8c2587b4313752a387651a






  const [newMessage, setMessage] = useState([]);
  const [newReciver, setReciver] = useState([]);
  const [newiconimg, seticonimg] = useState([]);

  //create user function
  const useersCollectionREf = collection(db, "replies");


  const createReply = async () => {
    if (newMessage != "") {
      await addDoc(useersCollectionREf, { message: newMessage, time: serverTimestamp(), sender: userlogged.email, reciver: newReciver, itemid: itemid, imagecon: newiconimg, });
      Swal.fire(
        'Good job!',
        'You commented successfully!',
        'success'
      );

    }
    else {
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'Enter your comment!',
      })


    }
  }






  const [uploadinfo, setUploadImageInfo] = useState([]);
  const uploadsCollectionREf = collection(db, "uploads");
  const deleteUploads = async (id) => {
    const uploadedDoc = doc(db, "uploads", id);
    await deleteDoc(uploadedDoc);
  };



  var weathlong = 80.0415729; var weatlat = 6.8213291;



  ////////////-----------------------------------------------

  const messagesRef = collection(db, "replies");
  //const query = messagesRef.orderBy('time').limit(25);
  const [replyinfo, setreplyInfo] = useState([]);

  const [reply2info, setreply2Info] = useState([]);

  // const [messages] = useCollectionData(query, { idField: 'id' });


  const [weatherlat, setWeatherLat] = useState([]);
  const [weatherlong, setWeatherLong] = useState([]);
  const [weatherdata, setwData] = useState([]);
  const [currentweatherdata, setcurrentwData] = useState([]);
  //var data2=weatherdata["current"];

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


    onSnapshot(collection(db, "replies"), orderBy("time"), (snapshot) => {
      setreply2Info(snapshot.docs.map((doc) => ({ ...doc.data(), id: doc.id })))
    })
    console.log(reply2info);
    /*
    var o=getWeatherFromApiAsync(6.8213291,80.0415729);
    setWeatherData(o);
    console.log("checkkkkkkk");
    console.log(o);
     */





    const fetchData = async () => {
      //`https://api.openweathermap.org/data/2.5/onecall?lat=6.8213291&lon=80.0415729&exclude=hourly,daily&appid=a32e9315ac8c2587b4313752a387651a`
      var linkw = 'https://api.openweathermap.org/data/2.5/onecall?lat=' + weatlat + '&lon=' + weathlong + '&exclude=hourly,daily&appid=a32e9315ac8c2587b4313752a387651a'
      await fetch(linkw)
        .then(res => res.json())
        .then(result => {
          setwData(result);
          setcurrentwData(result);
        });
    }
    fetchData();



  }, []);


  //google map related-----
  const { isLoaded, loadError } = useLoadScript({
    googleMapsApiKey: "AIzaSyBheNEtrngM3cbowGS3tLPwoBXlswmmSb0",
    libraries,
  });
  if (loadError) return "Error";
  if (!isLoaded) return "Loading...";
  //--------
  /*
  getWeatherFromApiAsync(6.8213291,80.0415729);
  console.log("mmm see");
  console.log(WeatherData);*/



  return (

    <div className="App" style={{ backgroundColor: `#f8fcf9`, marginTop: '5%' }}>

      <h1>Item</h1>

      {uploadinfo.map((up) => {
        var myTime = up.time;
        var foo = myTime.toDate().toString();




        if (up.id == itemid) {


          return (<div>
            <div class="row">

              <div class="col-sm-4">
                {""}
                <div class="card" >
                  <div class="container-fluid" >
                    <img src={up.downloadURL} alt="..."></img>

                  </div>
                  <div class="card-body">
                    <h5 class="card-title">{up.sender}</h5>
                    <p class="card-text">{up.message}</p>
                    <p class="card-text">{up.long}</p>
                    <p class="card-text">{up.lat}</p>
                    <p class="card-text"><small class="text-muted">{foo}</small></p>
                  </div>
                </div>
                <h5>&nbsp;&nbsp;</h5>
                <button type="button" class="btn btn-outline-danger"
                  onClick={() => {
                    //  deleteUploads(up.id);


                    Swal.fire({
                      title: 'Are you sure?',
                      text: "You won't be able to revert this!",
                      icon: 'warning',
                      showCancelButton: true,
                      confirmButtonColor: '#28a745',
                      cancelButtonColor: '#d33',
                      confirmButtonText: 'Yes, delete it!'
                    }).then((result) => {
                      if (result.isConfirmed) {
                        deleteUploads(up.id);
                        Swal.fire(
                          'Deleted!',
                          'Your file has been deleted.',
                          'success'
                        );
                        navigate(`/Solution`);
                      }
                    })

                  }




                  }
                >
                  {" "}
                  Delete Post
                </button>
              </div>
              <div class="col-sm-4">


                <GoogleMap
                  mapContainerStyle={mapContainerStyle}
                  zoom={15}
                  center={{
                    lat: up.lat,
                    lng: up.long
                  }
                  }>
                  <Marker position={{ lat: up.lat, lng: up.long }} />
                </GoogleMap>



              </div>

              <div class="col-sm-4">

                <h1>
                  weather
                  <br />

                  <h5>
                    area -
                    {weatherdata.timezone}
                    <br />
                    pressure -
                    {weatherdata["current"].pressure}hPa
                    <br />
                    humidity -
                    {weatherdata["current"].humidity}%
                    <br />
                    uvi -
                    {weatherdata["current"].uvi}
                    <br />
                    temp -
                    {weatherdata["current"].temp}K

                  </h5>

                  <br />



                  comments
                  {/*WeatherData.main && (
                <div className="city">
                    <h2 className="city-name">
                        <span>{WeatherData.name}</span>
                        <sup>{WeatherData.sys.country}</sup>
                    </h2>
                    <div className="city-temp">
                        {Math.round(WeatherData.main.temp)}
                        <sup>&deg;C</sup>
                    </div>
                    <div className="info">
                        <img className="city-icon" src={`https://openweathermap.org/img/wn/${WeatherData.WeatherData[0].icon}@2x.png`} alt={WeatherData.WeatherData[0].description} />
                        <p>{WeatherData.weather[0].description}</p>
                    </div>
                </div>
                  )*/}


                </h1>

                {reply2info.map((replyy) => {
                  if (replyy.itemid == itemid) {
                    return (<div>
                      {""}
                      <h5>
                        {replyy.message}
                      </h5>


                    </div>)
                  }
                })}


                <input placeholder="Message" onChange={(event) => {


                  setMessage(event.target.value); setReciver(up.sender); seticonimg(up.downloadURL);

                }} />

                <h5>&nbsp;&nbsp;</h5>

                <button class="btn btn-outline-success"
                  /*onClick={createUser
                  
                  
                  }*/
                  onClick={() => {
                    //  deleteUploads(up.id);
                    createReply();

                  }




                  }




                >




                  Create Reply</button>




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

export default Item;
