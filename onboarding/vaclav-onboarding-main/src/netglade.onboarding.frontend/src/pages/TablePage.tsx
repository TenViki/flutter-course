import React, { useState, useEffect, useRef } from "react";
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import Navbar from "../components/Navbar";
import request from '../api/request';
import { useQuery, useMutation } from '@tanstack/react-query'
import { Calendar, CalendarChangeEvent } from 'primereact/calendar';
import { Button } from "primereact/button";
import { Toast } from 'primereact/toast'
import { useAuthStore } from "../store/authStore";
import { InputNumber } from 'primereact/inputnumber';


interface telemetry {
    id: number,
    timestamp: number,
    temperature: number,
    altitude: number,
    radiation: number,
    velocity: number
}

function TablePage() {
    const [startingTimeStamp, setStartingTimeStamp] = useState<number>(Math.floor(Date.now() / 1000) - 500)
    const [endingTimeStamp, setEndingTimeStamp] = useState<number>(Math.floor(Date.now() / 1000))
    const [chosenDate, setChosenDate] = useState<string | Date | Date[] | null>(null)
    const [selectedTelemetry, setSelectedTelemetry] = useState<telemetry>()
    const [minAltitude, setMinAltitude] = useState<number>(0)
    const [maxAltitude, setMaxAltitude] = useState<number>(4611686018427388000)
    const toast = useRef<Toast>(null);
    const isAdmin = useAuthStore(state => state.isAdmin);

    const favouriteTelemetryMutation = useMutation({
        mutationFn: async () => await request.post("/favourite-telemetry", null, {
            params: {
                userId: useAuthStore.getState().id,
                telemetryId: selectedTelemetry?.id
            }
        }),
        onSuccess: () => {
            toast.current?.show({ severity: 'success', summary: 'Success', life: 3000 });
        },
        onError: (error: any) => {
            toast.current?.show({ severity: 'error', summary: 'Error', detail: error.message, life: 3000 });
        }
    })

    const deleteTelemetryMutation = useMutation({
        mutationFn: async () => await request.delete("/telemetry", {
            params: {
                telemetryId: selectedTelemetry?.id
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

    function updateTime() {
        if (chosenDate == null) {
            setEndingTimeStamp(Math.floor(Date.now() / 1000))
            setStartingTimeStamp(Math.floor(Date.now() / 1000) - 500)
        }
    }

    setInterval(updateTime, 5000);

    const query = useQuery(
        {
            queryKey: ['telemetryTable'],
            queryFn: async () => {
                const response = await request.get('/telemetry', {
                    params: {
                        startingTimeStamp: startingTimeStamp,
                        endingTimeStamp: endingTimeStamp,
                        lowestAltitude: minAltitude,
                        highestAltitude: maxAltitude,
                        page: 1,
                        pageSize: 99,
                    }
                });
                const formattedData = response.data?.map((item: { telemetryId: number, timestamp: number, temperature: number, altitude: number, radiation: number, velocity: number, }) => {
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
            },
            refetchInterval: 5000,
        }
    )

    return (
        <div>
            <Navbar activeIndex={0} />
            <Toast ref={toast} />
            <div className="h-screen w-screen flex justify-center">
                <div className="relative">
                    <div className="py-2 flex">
                        <div  className="w-max justify-start flex">
                            <div>
                                <label className="text-black">Choose a date</label>
                                <p></p>
                                <Calendar value={chosenDate} showTime hourFormat="24" onChange={(e: CalendarChangeEvent) => {
                                    if (e.value != null) {
                                        setChosenDate(e.value as Date)
                                        setEndingTimeStamp(Math.floor((e.value as Date).getTime() / 1000))
                                        setStartingTimeStamp(Math.floor((e.value as Date).getTime() / 1000) - 500)
                                    }
                                    else {
                                        setChosenDate(null)
                                        setEndingTimeStamp(Math.floor(Date.now() / 1000))
                                        setStartingTimeStamp(Math.floor(Date.now() / 1000) - 500)
                                    }
                                }} />
                            </div>
                            <p></p>
                            <div className="px-4 ">
                                <label className="text-black">Choose min. altitude</label>
                                <p></p>
                                <InputNumber inputId="minAltitude" value={minAltitude} onChange={()=>query.refetch()} onValueChange={(e) => setMinAltitude(e.value as number)} min={0} max={maxAltitude - 1} />
                            </div>
                            <div>
                                <label className="text-black">Choose max. altitude</label>
                                <p></p>
                                <InputNumber inputId="maxAltitude" value={maxAltitude}  onChange={()=>query.refetch()} onValueChange={(e) => setMaxAltitude(e.value as number)} min={minAltitude + 1} max={4611686018427388000} />
                            </div>

                            <div className="absolute right-40 top-5">
                                {isAdmin ? (<Button label="Delete telemetry" className="p-button-raised p-button-rounded" onClick={() => { deleteTelemetryMutation.mutate() }} />) : null}
                            </div>
                            <div className="absolute right-0 top-5">
                                <Button label="Add to favourites" className="p-button-raised p-button-rounded" onClick={() => { favouriteTelemetryMutation.mutate() }} />
                            </div>
                        </div>

                    </div>
                    <DataTable value={query.data} sortField="time" selectionMode="single" selection={selectedTelemetry} onSelectionChange={e => setSelectedTelemetry(e.value as telemetry)} sortOrder={-1} paginator rows={10} tableStyle={{ minWidth: '100rem' }} className="p-datatable-striped p-datatable-gridlines">
                        <Column field="time" sortable header="Time" />
                        <Column field="temperature" sortable header="Temperature" />
                        <Column field="altitude" sortable header="Altitude" />
                        <Column field="radiation" sortable header="Radiation" />
                        <Column field="velocity" sortable header="Velocity" />
                    </DataTable>
                </div>
            </div>
        </div>
    )
}

export default TablePage;