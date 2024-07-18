import React, {useRef} from "react";
import { useNavigate } from 'react-router-dom';
import  request  from '../api/request';
import { Formik, useFormik,Form,Field, ErrorMessage } from 'formik';
import useRegistrationMutation from "../hooks/useRegisterMutation";
import * as Yup from 'yup';
import { Toast } from "primereact/toast";


function Register() {   

    const mutation = useRegistrationMutation();
    const navigate= useNavigate();
    const toast = useRef<Toast>(null);
    const navigateTo = (path:string) => {
        navigate(path);
    };
    const SignupSchema = Yup.object().shape({
        username: Yup.string()
          .min(2, 'Too Short!')
          .max(50, 'Too Long!')
          .required('Required'),
        email: Yup.string()
          .email('Invalid email')
          .required('Required'),
        password: Yup.string()
          .min(5, 'Too Short!')
          .max(50, 'Too Long!')
          .matches(
            /([A-Z])/,
            'Must contain uppercase.'
          )
          .matches(
            /([a-z])/,
            'Must contain lowercase.'
          )
          .matches(
            /([0-9])/,
            'Must contain a number.'
          )
          .matches(
            /([!-/]|[:-@]|[[-_]|[{-~])/,
            'Must contain a special character.'
          )
          .required('Required'),
      });
      const fieldStyle={
        padding:'1em',
        fontSize: '1em',
        borderRadius: '0.25em',
        border: '2px solid black'

      }
      
    return (
        <div className="items-center overflow-hidden "> 
        <Toast ref={toast} />
            <h1 className="text-3xl font-bold py-4">Register</h1>
            <Formik
                initialValues={{
                    username: '',
                    email: '',
                    password: '',
              }}
              validationSchema={SignupSchema}
              onSubmit={async values => {
                try{
                  await mutation.mutateAsync(values)
                  navigateTo('/login')
                }
                catch{
                  toast.current?.show({ severity: 'error', summary: 'Error', detail: (mutation.error as any).message, life: 3000 });
                }          
              }}


            >{({ errors, touched, isValid }) => (
            <Form >
                <label htmlFor="username" className="px-4 py-4 block">Username</label>
                <Field name="username" style={fieldStyle} />
                <p/>
                <ErrorMessage name="username" component="div" className="text-red-500 font-bold"/>

                <label htmlFor="email" className="px-4 py-4 block">Email</label>
                <Field name="email" type="email" style={fieldStyle}/>
                <p/>
                <ErrorMessage name="email" component="div" className="text-red-500 font-bold" />

                <label htmlFor="password" className="px-4 py-4 block">Password</label>
                <Field name="password" type="password" style={fieldStyle} />
                
                <ErrorMessage name="password" component="div" className="text-red-500 font-bold"/>

                <p className="block py-4"/>
                {isValid && !mutation.isLoading ? (<button type="submit" className="text-white px-4 py-4 sm:px-8 sm:py-3 bg-yellow-400 hover:bg-yellow-500 rounded">Submit</button>):<button type="submit" className="text-white px-4 py-4 sm:px-8 sm:py-3 bg-gray-500 rounded" disabled>Submit</button>}
                <p className="block py-4"/>
                <a href="/login" className="text-blue-600 visited:text-purple-600 hover:underline">Already have an account? Login here.</a>
            </Form>
            )}
            </Formik>
        </div>
    );
}


export default Register;