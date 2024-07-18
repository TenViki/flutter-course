import React, {useRef} from "react";
import Navbar from "../components/Navbar";
import { useAuthStore } from '../store/authStore';
import { Calendar, CalendarChangeEvent } from 'primereact/calendar';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { useState } from "react";
import { useQuery,useMutation } from "@tanstack/react-query";
import { useEffect } from "react";
import { Button } from "primereact/button";
import {Toast} from 'primereact/toast'
import request from "../api/request";

interface telemetry{
    id:number,
    timestamp:number,
    temperature:number,
    altitude:number,
    radiation:number,
    velocity:number
}
function Favourites() {
    const [endingTimeStamp, setEndingTimeStamp] = useState<number>(Math.floor(Date.now() / 1000))
    const [chosenDate, setChosenDate] = useState<string | Date | Date[] | null>(null)
    const [selectedTelemetry, setSelectedTelemetry] = useState<telemetry>()
    const toast = useRef<Toast>(null);
    const query = useQuery(
        {
            queryKey: ['favouriteTelemetry'],
            queryFn: async () => {
                const response = await request.get('/favourite-telemetry',
                {
                    params: {
                        userId: useAuthStore.getState().id,
                        endingTimeStamp: endingTimeStamp
                    },
                    
                });
                const data = response.data;
                const formattedData = data?.map((item:{telemetryId:number,timestamp:number,temperature:number,altitude:number,radiation:number, velocity:number,}) => {
                    const date = new Date(item.timestamp * 1000);
                    const formattedTime = date.toLocaleTimeString();
                    return {
                        
                        id: item.telemetryId,
                        time: formattedTime,
                        temperature: item.temperature,
                        altitude: item.altitude,
                        radiation: item.radiation,
                        velocity: item.velocity
                    };
                });
                return formattedData;

            }})



    const favouriteTelemetryMutation = useMutation({
            mutationFn: async () => await request.delete("/favourite-telemetry", {
                params:{
                    userId: useAuthStore.getState().id,
                    telemetryId: selectedTelemetry?.id
                }
             }),
            onSuccess: () => {
                toast.current?.show({severity:'success', summary: 'Success', life: 3000});
                query.refetch();
            },
            onError:(error:any)=>{
                toast.current?.show({severity:'error', summary: 'Error', detail:error.message, life: 3000});
                
            }
          })

    

    return (
        <div>
        <Navbar activeIndex={2} />
        <Toast ref={toast} />
        <div className="h-screen w-screen flex justify-center">
            <div className="relative">
            <div className="py-2 flex-none w-max">
                    <div>
                        <label className="text-black">Choose a date</label>
                        <p></p>
                        <Calendar value={chosenDate} showTime hourFormat="24" onChange={(e: CalendarChangeEvent) =>{
                        if(e.value != null)
                        {
                            setChosenDate(e.value as Date)
                            setEndingTimeStamp(Math.floor((e.value as Date).getTime() / 1000))
                        }
                        else
                        {
                            setChosenDate(null)
                            setEndingTimeStamp(Math.floor(Date.now() / 1000))
                        }
                        query.refetch()
                        }}/>
                    </div>
                    <div className="absolute right-0 top-5">
                        <Button label="Remove from favourites" className="p-button-raised p-button-rounded" onClick={() => {favouriteTelemetryMutation.mutate()}}/>
                    </div>
                </div>
                <DataTable value={query.data} sortField="time" selectionMode="single" selection={selectedTelemetry} onSelectionChange={e => setSelectedTelemetry(e.value as telemetry)} sortOrder={-1} paginator rows={10}  tableStyle={{ minWidth: '100rem' }} className="p-datatable-striped p-datatable-gridlines">
                    <Column field="time" sortable header="Time" />
                    <Column field="temperature" sortable header="Temperature" />
                    <Column field="altitude" sortable header="Altitude" />
                    <Column field="radiation" sortable header="Radiation" />
                    <Column field="velocity" sortable header="Velocity" />
                </DataTable>
            </div>
        </div>  
        </div>
    );
}

export default Favourites;