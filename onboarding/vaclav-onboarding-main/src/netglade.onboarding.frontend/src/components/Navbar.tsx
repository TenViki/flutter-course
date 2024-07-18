import React,{useState} from 'react';
import { useNavigate } from 'react-router-dom';
import { TabMenu } from 'primereact/tabmenu';
import { useAuthStore } from '../store/authStore';
function Navbar({activeIndex}:{activeIndex:number}) {

    const navigate= useNavigate();
    const navigateTo = (path:any) => {
        navigate(path);
      };
    const isAdmin = useAuthStore(state => state.isAdmin);
    const items = [
        {label: 'Home', icon: 'pi pi-fw pi-home',command: () => navigateTo('/')},
        {label: 'Graphs',icon: 'pi pi-fw pi-map',command: () => navigateTo('/graphs')  },
        {label: 'Favourites',icon: 'pi pi-fw pi-heart',command: () => navigateTo('/favourites') },
        {label: 'Errors',icon: 'pi pi-fw pi-trash',command: () => navigateTo('/errors')  },
        {label: 'Profile',icon: 'pi pi-fw pi-user',command: () => navigateTo('/profile')  }
    ];

    if (isAdmin) {
        items.push({ label: 'Admin Dashboard', icon: 'pi pi-fw pi-cog', command: () => navigateTo('/admin') });
    }
    return (
        <div className="card">
            <TabMenu model={items} activeIndex={activeIndex} />
        </div>
    )
}

export default Navbar;