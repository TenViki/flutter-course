import {create} from 'zustand'


interface AuthStore {
    token: string | null,
    username: string | null,
    email: string | null,
    id: string | null,
    isAdmin: boolean | null,
    actions: {
        setToken: (newToken: string | null) => void
        setUsername: (newUsername: string | null) => void
        setEmail: (newEmail: string | null) => void
        setId: (newId: string | null) => void
        setIsAdmin: (newIsAdmin: boolean | null) => void
    }
}

export const useAuthStore = create<AuthStore>((set) => ({
    token: null,
    username: null,
    email: null,
    id: null,
    isAdmin: null,
    actions: {
    setToken: (newToken) => set((state) => ({token:newToken })), 
    setUsername: (newUsername) => set((state) => ({username:newUsername })),
    setEmail: (newEmail) => set((state) => ({email:newEmail })),
    setId: (newId) => set((state) => ({id:newId })),
    setIsAdmin: (newIsAdmin) => set((state)=>({isAdmin:newIsAdmin}))
    }
  }))