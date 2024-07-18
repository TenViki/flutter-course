import React from 'react';
import './App.css';
import "primereact/resources/themes/saga-orange/theme.css";   
import "primereact/resources/primereact.min.css";    
import 'primeicons/primeicons.css';
import {useAuthStore} from './store/authStore';
import Routes  from './components/routes/Routes';
import { BrowserRouter } from 'react-router-dom';


function App() {
  
  const token = useAuthStore(state => state.token);
  
  return ( 
    <div className='bg-slate-100 min-h-screen max-h-fit'>
      <div className='App'>
        <Routes isAuthenticated={token!= null}/>
      </div>  
    </div>
      
  );
}

export default App;
