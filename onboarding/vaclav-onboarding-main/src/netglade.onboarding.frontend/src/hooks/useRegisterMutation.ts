
import request from "../api/request";
import {useMutation,} from '@tanstack/react-query';
import { useNavigate } from 'react-router-dom';


function useRegistrationMutation() {

  

    const registrationMutation = useMutation({
        mutationFn: async (values:{username:string,email:string, password:string}) => await request.post("http://localhost:5104/register", {
            username:values.username,
            email:values.email,
            password:values.password
         }),
    })


  return registrationMutation;
}

export default useRegistrationMutation;