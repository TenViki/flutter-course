import { useAuthStore } from "../store/authStore";
import request from "../api/request";
import {useMutation,} from '@tanstack/react-query';
import jwt_decode from 'jwt-decode';

function useLoginMutation() {
  const actions = useAuthStore((state) => state.actions);


  const login = ({ data}:{data:{data:{token:string}}}) => {
    actions.setToken(data.data.token);
     request.defaults.headers.common[
      "Authorization"
    ] = `Bearer ${data.data.token}`;
    const decodedToken:any = jwt_decode(data.data.token);
    actions.setUsername(decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"]);
    actions.setEmail(decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"]);
    actions.setId(decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"]);
    const roleArray:string[] = decodedToken["http://schemas.microsoft.com/ws/2008/06/identity/claims/role"];
    if(roleArray.includes("Administrator"))
    {
      actions.setIsAdmin(true);
    }
    else
    {
      actions.setIsAdmin(false);
    }
  };

  const loginMutation = useMutation({
    mutationFn: async (values:{username:string,password:string}) => await request.post("http://localhost:5104/login", {
        username: values.username,
        password: values.password
     }),
    onSuccess: (data) => {
        console.log(data.data.token)
        login({ data})
    }
  })

  return loginMutation;
}

export default useLoginMutation;