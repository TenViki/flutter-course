
import Temperature from "../components/graphs/Temperature";
import Altitude from "../components/graphs/Altitude";
import Radiation from "../components/graphs/Radiation";
import Velocity from "../components/graphs/Velocity";
import Navbar from "../components/Navbar";
import request from '../api/request';
import { useQuery } from '@tanstack/react-query'

function GraphPage() {

    const query=useQuery(
        {
            queryKey: ['telemetry'],
            queryFn: async () => await request.get('/telemetry',{
                params: {
                  startingTimeStamp: (Math.floor(Date.now() / 1000) -100),
                  endingTimeStamp: 4611686018427388000,
                  lowestAltitude: 0,
                  highestAltitude: 4611686018427388000,
                  page: 1,
                  pageSize: 30,
                }
              }),
            refetchInterval: 5000,
        }
    )
    
    
    return (
        <div>
        <Navbar activeIndex={1} />
        <div className="flex py-2">
            <div className=" float-right pr-10 pl-20 w-1/2">
                <Temperature query={query} />
                <Altitude query={query}  />
            </div>
            <div className=" float-left pr-20 pl-10 w-1/2">
                <Radiation query={query} />
                <Velocity query={query}/>
            </div>
        </div>
        
        </div>

    )
}

export default GraphPage;