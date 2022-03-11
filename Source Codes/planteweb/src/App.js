import logo from './logo.svg';
import { useState, useEffect } from 'react';//react hooks we use
import './App.css';
import { Card } from './Card';
import Home from './Home';
import Login from './Login';
//import { useState } from 'react';
import { db, auth } from './firebase-config';
import { collection, getDocs, addDoc, updateDoc, doc, deleteDoc } from "firebase/firestore";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  onAuthStateChanged,
  signOut,
} from "firebase/auth";


function App() {


  // login related

  const [registerEmail, setRegisterEmail] = useState("");
  const [registerPassword, setRegisterPassword] = useState("");
  const [loginEmail, setLoginEmail] = useState("");
  const [loginPassword, setLoginPassword] = useState("");
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

  const [users, setUsers] = useState([]);
  const [uploadinfo, setUploadImageInfo] = useState([]);

  const useersCollectionREf = collection(db, "users")
  const uploadsCollectionREf = collection(db, "uploads")


  //grab info and store,for thar create two states
  const [newName, setNewName] = useState([]);
  const [newAge, setNewAge] = useState([0]);//[0] because its a number


  //create user function

  const createUser = async () => {
    await addDoc(useersCollectionREf, { name: newName, age: Number(newAge) });

  }

  //update user function

  const updateUserAge = async (uid, age) => {

    const userDoc = doc(db, "users", uid)//identifing the doc to update
    const newField = { age: age + 1 };
    await updateDoc(userDoc, newField);
    ////<button onClick={updateUserAge(users.id,users.age)} >{""}increase age</button>
  }
  const deleteUser = async (id) => {
    const userDoc = doc(db, "users", id);
    await deleteDoc(userDoc);
  };




  useEffect(() => {

    const getUsers = async () => {
      const data = await getDocs(useersCollectionREf);
      // console.log(data);
      setUsers(data.docs.map(((doc) => ({ ...doc.data(), id: doc.id }))))

    }
    getUsers()

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

          <h4> User Logged In: </h4>
          {user?.email}

          <button onClick={logout}> Sign Out </button>





          <div><h1>---------------------------------------------------------------------------------------------------------------------
          </h1></div>
          <input placeholder="Name" onChange={(event) => { setNewName(event.target.value); }} />
          <input type="number" placeholder="age" onChange={(event) => { setNewAge(event.target.value); }} />
          <button onClick={createUser}>Create User</button>















          {users.map((users) => {
            return (<div>
              {""}<h1>
                Name:{users.name}</h1>
              <h1>
                Age:{users.age}
              </h1>
              <h1>
                Age:{users.id}
              </h1>
              <button type="button" class="btn btn-primary"
                onClick={() => {
                  deleteUser(users.id);
                }}
              >
                {" "}
                Delete User
              </button>
            </div>)
          })}

          <div><h1>---------------------------------------------------------------------------------------------------------------------
          </h1></div>

          {uploadinfo.map((up) => {
            return (<div>
              {""}

              <img src={up.downloadURL}></img>
              <h2>
                message:{up.message}
              </h2>
              <h1>
                sender:{up.sender}
              </h1>
              <button type="button" class="btn btn-primary"
                onClick={() => {
                  deleteUser(users.id);
                }}
              >
                {" "}
                Delete User
              </button>
            </div>)
          }





          )}

          <div><h1>---------------------------------------------------------------------------------------------------------------------
          </h1></div>


          {uploadinfo.map((up) => {
            return (<div class="col-sm-4">
              {""}
              <div class="card" >
                <img src={up.downloadURL} alt="..."></img>
                <div class="card-body">
                  <h5 class="card-title">{up.sender}</h5>
                  <p class="card-text">{up.message}</p>
                  <p class="card-text"><small class="text-muted">time</small></p>
                </div>
              </div>
              <Card />
            </div>



            )



          }

          )



          }
        </section>


      ) : (
        <section>
          


          
          <input
            placeholder="email"
            onChange={(event) => {
              setemailAddress(event.target.value);
            }}
                    
          />
            <h1>{emailError}</h1>
         
          <input
            placeholder="Password" type="password"
            onChange={(event) => {
              setauthPassword(event.target.value);
            }}
            
          />
          <h1>{passwordError}</h1>

          <div className='buttonContainer'>
          {hasAccount?(
          <>
          <button onClick={register}> sign up</button>
          <p>
            Don't have an account?
            <span onClick={()=>setHasAccount(false)}>Signup</span>
          </p>
          </>
          ):(
            <>
            <button onClick={login}>sign in</button>
          <p>
            have an account?
            <span onClick={()=>setHasAccount(true)}>Signup</span>
          </p>
          </>
          )}
          </div>
       
















        </section>
      )}





    </div>
  );

}

export default App;


