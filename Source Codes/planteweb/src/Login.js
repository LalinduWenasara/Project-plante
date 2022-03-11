import React from 'react';
import './App.css';


const Login =(props) =>{

    const {
        loginEmail,
        registerEmail,
        registerPassword,
        loginPassword,
        emailError,
        passwordError,
        login,
        register,
     
    }= props;
   return(
       <section className='login'>
          
        
        <h3> Register User </h3>
        <input
          placeholder="Email..."
          onChange={(event) => {
            registerEmail(event.target.value);
          }}
        />
        <input
          placeholder="Password..."
          onChange={(event) => {
            registerPassword(event.target.value);
          }}
        />
         <button onClick={register} > Sign u up</button>
      
     
        
        <h3> Login </h3>
        <input
          placeholder="Email..."
          onChange={(event) => {
            loginEmail(event.target.value);
          }}
        />
        <input
          placeholder="Password..."
          onChange={(event) => {
            loginPassword(event.target.value);
          }}
        />
        <button onClick={login}> Login</button>
    
  















           </section>
   )

};

export default Login;

     /*   <Login loginEmail={setLoginEmail}
        registerEmail={setRegisterEmail}
        registerPassword={setRegisterPassword}
        loginPassword={setLoginPassword}
        emailError={setEmailError}
        passwordError={setPasswordError}
        login
        register
      
      />*/
