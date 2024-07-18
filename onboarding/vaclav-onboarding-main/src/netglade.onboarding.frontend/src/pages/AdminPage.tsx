import React,{ useEffect, useRef} from "react";
import Navbar from "../components/Navbar";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import request from "../api/request";
import { useAuthStore } from "../store/authStore";
import { Button } from "primereact/button";
import { useMutation } from "@tanstack/react-query";
import {Toast} from 'primereact/toast'

interface User {
    id: string,
    name: string,
    isAdmin: boolean
}
function AdminPage() {
    const [selectedUser, setSelectedUser] = useState<User>()
    const adminId = useAuthStore(state => state.id);
    const toast = useRef<Toast>(null);
    const addRights = useMutation({
        mutationFn: async (userId:string) => await request.post("/users/give-admin-rights",null, {
            params:{
                userId:userId
            }
        }),
        onSuccess: () =>{
            query.refetch();
            toast.current?.show({severity:'success', summary: 'Success', life: 3000});
        },
        onError:(error:any)=>{
            toast.current?.show({severity:'error', summary: 'Error', detail:error.message, life: 3000});
        } 
    })

    
    const removeRights =  useMutation({
        mutationFn: async (userId:string) => await request.post("/users/remove-admin-rights",null, {
            params:{
                userId:userId
            }
        }),
        onSuccess: () =>{
            query.refetch();
            toast.current?.show({severity:'success', summary: 'Success', life: 3000});
        },
        onError:(error:any)=>{
            toast.current?.show({severity:'error', summary: 'Error', detail:error.message, life: 3000});
        } 
    })
    const archiveUser =  useMutation({
        mutationFn: async (userId:string) => {
            const url = `/users/${userId}`
            await request.delete(url, {
            params:{
                userId:userId,
                adminId: adminId

            }
        })},
        onSuccess: () =>{
            query.refetch();
            toast.current?.show({severity:'success', summary: 'Success', life: 3000});
        },
        onError:(error:any)=>{
            toast.current?.show({severity:'error', summary: 'Error', detail:error.message, life: 3000});
        } 
    })
    const reinstateUser =  useMutation({
        mutationFn: async (userId:string) =>{ 
            const url = `/users/${userId}`
            await request.post(url,null, {
            params:{
                userId:userId
            }
        })},
        onSuccess: () =>{
            query.refetch();
            toast.current?.show({severity:'success', summary: 'Success', life: 3000});
        },
        onError:(error:any)=>{
            toast.current?.show({severity:'error', summary: 'Error', detail:error.message, life: 3000});
        } 
    })

    const query = useQuery({
        queryKey: ['userTable'],
        queryFn: async () => {
          const response = await request.get('/users/get-all', {
            params: {
              userId: adminId
            }
          });
      
          const data = response.data;
      
          const formattedData = data?.map((item:any) => {
            return {
              isDeleted: item.isDeleted,
              id: item.id,
              name: item.name,
              isAdmin: item.userRoles.includes("Administrator")
            };
          });
      
          return formattedData;
        },
        }
    )

    return (
        <div>
            <Navbar activeIndex={5} />
            <Toast ref={toast} />
            <div className="py-4 w-screen flex justify-center">
                <button onClick={()=>{addRights.mutate(selectedUser?.id!)}} className="text-white px-8 py-4 sm:px-8 sm:py-3 bg-green-500 hover:bg-green-600 rounded">Add admin rights</button>
                <div className="w-8"></div>
                <button onClick={()=>{removeRights.mutate(selectedUser?.id!)}} className="text-white px-4 py-4 sm:px-8 sm:py-3 bg-red-500 hover:bg-red-600 rounded">Remove admin rights</button>
                <div className="w-20"></div>
                <button onClick={()=>{reinstateUser.mutate(selectedUser?.id!)}} className="text-white px-8 py-4 sm:px-8 sm:py-3 bg-green-500 hover:bg-green-600 rounded">Reinstate user</button>
                <div className="w-8"></div>
                <button onClick={()=>{archiveUser.mutate(selectedUser?.id!)}} className="text-white px-4 py-4 sm:px-8 sm:py-3 bg-red-500 hover:bg-red-600 rounded">Delete user</button>
            </div>
            <div className="h-screen w-screen flex justify-center">
                <div className="relative py-4">
                    <DataTable value={query.data}  sortField="name" selectionMode="single" selection={selectedUser} onSelectionChange={e => setSelectedUser(e.value as User)} sortOrder={-1} paginator rows={10} tableStyle={{ minWidth: '100rem' }} className="p-datatable-striped p-datatable-gridlines">
                        <Column field="id" sortable header="User Id" />
                        <Column field="name" sortable header="Name" />
                        <Column field="isAdmin" sortable header="Is user admin?" />
                        <Column field="isDeleted" sortable header="Is user deleted" />
                    </DataTable>
                </div>
            </div>
        </div>
    )
}

export default AdminPage;