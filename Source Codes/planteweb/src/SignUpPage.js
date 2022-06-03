import React from 'react';
import './App.css';
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
import { useNavigate } from 'react-router-dom';
import image from './images/fall.svg';
//import validator from 'validator'


function SignupPage() {

    const mystylebackground = {
        padding: "10px",
        fontFamily: "Arial"
    };

    const mystylecontainer = {
        margin: "5%",
        fontFamily: "Arial",
        textAlign: "left"
    };


    const [emailAddress, setemailAddress] = useState("");
    const [emailError, setEmailError] = useState("");
    const [passwordError, setPasswordError] = useState("");
    const [authPassword, setauthPassword] = useState("");
    const [hasAccount, setHasAccount] = useState(false);
    const [firstname, setFirstName] = useState("");
    const [Lastname, setLastName] = useState("");
    const [Mobilenumber, setMobilenumber] = useState("");
    const plantPathologistCollectionREf = collection(db, "PlantPathologist");

    const createUser = async () => {
        await addDoc(plantPathologistCollectionREf, { firstname: firstname, Lastname: Lastname, Mobilenumber: Mobilenumber, emailAddress: emailAddress });

    }

/*
    const [emailvalError, setEmailvalError] = useState('')
    const validateEmail = (e) => {
      var email = e.target.value
    
      if (validator.isEmail(email)) {
        setEmailError('Valid Email :)')
      } else {
        setEmailError('Enter valid Email!')
      }
    }


*/



    const register = async () => {

        clearErrors();
        try {
            const user = await createUserWithEmailAndPassword(
                auth,
                emailAddress,
                authPassword
            );
            createUser();

            navigate(`/`);
            console.log(user);
        } catch (error) {
            switch (error.code) {
                case "auth/invalid-email":
                    setEmailError("please enter valid email address");
                    break;
                case "auth/weak-password":
                    setPasswordError("Password should be at least 6 characters (Enter a strong password)");
                    break;
            }

            console.log(error.message);
        }
    };


    const clearErrors = () => {
        setEmailError('');
        setPasswordError('');
    }


    let navigate = useNavigate();


    return (
        <div className="App">
            <section style={mystylebackground}>

                <div class="container" style={mystylecontainer}>
                    <div class="row content">
                        <h1>Sign Up</h1>
                        <div class="col-md-6 mb-3">

                            <img src={image} class="img-fluid" alt="Responsive image"></img>
                        </div>
                        <div class="col-md-6">
                            <div >

                                <div class="row">
                                    <div class="col-sm">
                                        <div class="form-group">
                                            <label for="First Name">First Name</label>
                                            <input class="form-control"
                                                onChange={(event) => {
                                                    setFirstName(event.target.value);
                                                }}
                                            />
                                        </div>
                                    </div>
                                    <div class="col-sm">
                                        <div class="form-group">
                                            <label for="Last Name">Last Name</label>
                                            <input class="form-control"
                                                onChange={(event) => {
                                                    setLastName(event.target.value);
                                                }}
                                            />
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-sm">
                                        <div class="form-group">
                                            <label for="email">Email</label>
                                            
                                            <input class="form-control" type="email"
                                                onChange={(event) => {
                                                    setemailAddress(event.target.value);
                                                }}
                                            />
                                            <h1>{emailError}</h1>
                                        </div>
                                    </div>
                                    <div class="col-sm">
                                        <div class="form-group">
                                            <label for="mobile">Mobile Number</label>
                                            <input class="form-control"
                                                onChange={(event) => {
                                                    setMobilenumber(event.target.value);
                                                }}
                                            />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm">
                                        <div class="form-group">
                                            <label for="password">Password</label>
                                            < input class="form-control" type="password"
                                                onChange={(event) => { 
                                                    setauthPassword(event.target.value);
                                                }}
                                            />
                                            <h1>{passwordError}</h1>
                                        </div>
                                    </div>
                                    <div class="col-sm">
                                        <div class="form-group">
                                            <label for="password">Confirm Password</label>
                                            < input class="form-control" type="password"
                                                onChange={(event) => {
                                                    setauthPassword(event.target.value);
                                                }}
                                            />
                                            <h1>{passwordError}</h1>
                                        </div>
                                    </div>
                                </div>
                                <div style={mystylebackground}>
                                </div>

                                <div class="row">
                                    <div class="col-sm"> <button onClick={register} type="button" class="btn btn-outline-success"> sign up</button></div>
                                    <div class="col-sm"></div>

                                </div>

                                <p>
                                    Don't have an account?
                                    <span onClick={() => navigate(`/`)}>Signin</span>
                                </p>




                            </div>
                        </div>
                    </div>
                </div>

            </section>
        </div>
    );
}

export default SignupPage;
