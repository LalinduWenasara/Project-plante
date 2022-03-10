// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import {getFirestore} from '@firebase/firestore';
import { getAuth } from "firebase/auth";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyDVB4FPQGttgYgPzdzlzNE37OObW-AC1Gk",
  authDomain: "iot2-950b2.firebaseapp.com",
  databaseURL: "https://iot2-950b2-default-rtdb.firebaseio.com",
  projectId: "iot2-950b2",
  storageBucket: "iot2-950b2.appspot.com",
  messagingSenderId: "168976377918",
  appId: "1:168976377918:web:df5cf7b7d04b77d4e6496f"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const db = getFirestore(app);
export const auth = getAuth(app);