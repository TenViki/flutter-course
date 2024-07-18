import React from "react";
import { Button } from 'primereact/button';
import "../App.css"
import { useAuthStore } from '../store/authStore';
import Navbar from "../components/Navbar";
import request from "../api/request";
import jwt_decode from 'jwt-decode';


function Profile() {

  const actions = useAuthStore((state) => state.actions)
  const name = useAuthStore(state => state.username);
  const email = useAuthStore(state => state.email);
  function logout(){
    actions.setToken(null);
    request.defaults.headers.common[
      "Authorization"
    ] = null;
  }
  return(
    <div>
    <Navbar activeIndex={4} />
    <div className="profile">

      <h1 className="text-4xl font-bold py-3">Profile</h1>
      <h2 className="text-2xl font-bold py-3">Name:</h2>
      <p>{name}</p>
      <h2 className="text-2xl font-bold  py-3">Mail:</h2>
      <p className="pb-3">{email}</p>
      <Button label="Logout" onClick={logout}/>
    </div>
    </div>
  )
}

export default Profile;