import React, { useRef } from "react";
import "../App.css"
import { useAuthStore } from '../store/authStore';
import Navbar from "../components/Navbar";
import request from "../api/request";
import jwt_decode from 'jwt-decode';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { useQuery, useMutation } from '@tanstack/react-query'
import { useState, useEffect } from "react";
import { Toast } from 'primereact/toast';
import { Button } from "primereact/button";

interface error {
    id: number,
    timestamp: number,
    data: number,
    errorString: number
}

function Errors() {
    const toast = useRef<Toast>(null);
    const [tableData, setTableData] = useState<any[]>([]);
    const textDecoder = new TextDecoder('ascii');
    const [selectedError, setSelectedError] = useState<error>();
    const isAdmin = useAuthStore(state => state.isAdmin);


    const deleteErrorsMutation = useMutation({
        mutationFn: async () => await request.delete("/telemetry/errors", {
            params: {
                errorId: selectedError?.id
            }
        }),
        onSuccess: () => {
            toast.current?.show({ severity: 'success', summary: 'Success', life: 3000 });
            query.refetch();
        },
        onError: (error: any) => {
            toast.current?.show({ severity: 'error', summary: 'Error', detail: error.message, life: 3000 });
        }
    })

    const query = useQuery({
        queryKey: ['error'],
        queryFn: async () => {
          const response = await request.get('/telemetry/errors', {
            params: {
              page: 1,
              pageSize: 99,
            }
          });
      
          const data = response.data;
      
          const formattedData = data?.map((item:{id:number,timestamp:number,errorData:string}) => {
            const date = new Date(item.timestamp * 1000);
            const decodedData = atob(item.errorData);
            const byteArray = new Uint8Array(decodedData.length);
            for (let i = 0; i < decodedData.length; i++) {
              byteArray[i] = decodedData.charCodeAt(i);
            }
      
            const decodedString = textDecoder.decode(byteArray);
            const hexString = Array.from(byteArray, byte => byte.toString(16).padStart(2, '0')).join(' ');
            const formattedTime = date.toLocaleString();
            return {
              id: item.id,
              time: formattedTime,
              data: hexString,
              errorString: decodedString,
            };
          });
      
          return formattedData;
        },
        refetchInterval: 5000,

        }
    )


    return (
        <div>
            <Navbar activeIndex={3} />
            <Toast ref={toast} />
            <div className="w-11/12 flex justify-end py-2">
               {isAdmin? <Button label="Delete error" className="p-button-raised p-button-rounded" onClick={() => { deleteErrorsMutation.mutate() }} />: null}
            </div>
            <div className="h-screen w-screen flex justify-center">
                <div className="relative py-4">
                    <DataTable value={query.data} selectionMode="single" paginator rows={10} selection={selectedError} onSelectionChange={e => setSelectedError(e.value as error)} tableStyle={{ minWidth: '100rem' }} className="p-datatable-striped p-datatable-gridlines">
                        <Column field="time" header="Time" />
                        <Column field="data" header="Error data" />
                        <Column field="errorString" header="Error string" />
                    </DataTable>
                </div>
            </div>

        </div>
    )
}

export default Errors;