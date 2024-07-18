import { Chart } from 'primereact/chart';
import React,{ useState, useEffect } from "react";

const Velocity= ({ onClick,query } :any) => {
    const [chartData, setChartData] = useState({});
    const [chartOptions, setChartOptions] = useState({});

    useEffect(() => {
        const documentStyle = getComputedStyle(document.documentElement);
        const textColor = documentStyle.getPropertyValue('--text-color');
        const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
        const surfaceBorder = documentStyle.getPropertyValue('--surface-border');
        const timestamps = query.data?.data?.map((item:{timestamp:number}) => {
            const date = new Date(item.timestamp * 1000);
            const formattedTime = date.toLocaleTimeString();
            return `${formattedTime}`;
          });
        const velocities = query.data?.data?.map((item:{velocity:number}) => item.velocity);
        const data = {
            labels: timestamps,
            datasets: [
                {
                    label: 'Velocity',
                    data: velocities,
                    fill: false,
                    borderColor: documentStyle.getPropertyValue('--blue-500'),
                    tension: 0.2
                }
            ]
        };
        const options = {
            maintainAspectRatio: false,
            aspectRatio: 0.6,
            animation: {
                duration: 0,
            },
            plugins: {
                legend: {
                    labels: {
                        color: textColor
                    }
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder
                    }
                },
                y: {
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder
                    }
                }
            }
        };

        setChartData(data);
        setChartOptions(options);
    }, [query.data]);

    return (
        <div className='bg-white relative rounded-xl top-5 shadow-md hover:shadow-2xl' onClick={onClick}>
            <Chart type="line" data={chartData} options={chartOptions} />
        </div>
        

    )
}
export default Velocity;