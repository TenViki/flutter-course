import React  from "react";
import useLoginMutation from "../hooks/useLoginMutation";
import { useState,useRef } from "react";
import { useFormik } from 'formik';
import { Toast } from "primereact/toast";

function Login() {
    const toast = useRef<Toast>(null);

    const loginMutation = useLoginMutation();
    const formik = useFormik({
        initialValues: {
          username: '',
          password: '',
        },
        onSubmit: async values => {
          try{
            await loginMutation.mutateAsync(values)
          }
          catch{
            toast.current?.show({ severity: 'error', summary: 'Error', detail: (loginMutation.error as any).message, life: 3000 });
          }            

        },
    
      });
    
     
    
    return (
        
        <div className="items-center overflow-hidden "> 
        <Toast ref={toast} />
            <h1 className="text-3xl font-bold py-4">Login</h1>
            <form onSubmit={formik.handleSubmit}>
                <label htmlFor="username" className="px-4 py-4 block">Username</label>
                <input
                    id="username"
                    name="username"
                    type="text"
                    onChange={formik.handleChange}
                    value={formik.values.username}
                    className="px-4 py-4 outline rounded"
                />
                <label htmlFor="password" className="px-4 py-4 block">Password</label>
                <input
                    id="password"
                    name="password"
                    type="password"
                    onChange={formik.handleChange}
                    value={formik.values.password}
                    className="px-4 py-4  outline rounded"
                />
                <p className="block py-4"/>
                {loginMutation.isLoading?<button type="submit" className="text-white px-4 py-4 sm:px-8 sm:py-3  bg-gray-500 rounded" disabled>Submit</button> :<button type="submit" className="text-white px-4 py-4 sm:px-8 sm:py-3 bg-yellow-400 hover:bg-yellow-500 rounded">Submit</button>}
                <p className="block py-4"/>
                <a href="/register" className="text-blue-600 visited:text-purple-600 hover:underline">Don't have an account yet? Register here.</a>
            </form>
        </div>
        
    );
}

export default Login;