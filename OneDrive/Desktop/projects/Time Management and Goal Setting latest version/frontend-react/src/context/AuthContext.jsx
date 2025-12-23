import { createContext, useState, useContext, useEffect } from 'react';
import api from '../services/api';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null);
    const [loading, setLoading] = useState(true);

    const decodeToken = (token) => {
        try {
            const base64Url = token.split('.')[1];
            const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
            const jsonPayload = decodeURIComponent(atob(base64).split('').map(function (c) {
                return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
            }).join(''));
            return JSON.parse(jsonPayload);
        } catch (e) {
            return null;
        }
    };

    useEffect(() => {
        const token = localStorage.getItem('token');
        if (token) {
            const decoded = decodeToken(token);
            if (decoded) {
                // Assuming the token payload has 'role' and 'sub' (email)
                // Adjust based on your actual JWT structure
                setUser({
                    token,
                    email: decoded.sub,
                    role: decoded.role,
                    id: decoded.userId,
                    name: decoded.name
                });
            }
        }
        setLoading(false);
    }, []);

    const login = async (email, password) => {
        const response = await api.post('/auth/login', { email, password });
        const { token } = response.data;
        localStorage.setItem('token', token);
        const decoded = decodeToken(token);
        setUser({
            token,
            email: decoded.sub,
            role: decoded.role,
            id: decoded.userId,
            name: decoded.name
        });
        return token;
    };

    const signup = async (name, email, password) => {
        const response = await api.post('/auth/signup', { name, email, password });
        const { token } = response.data;
        localStorage.setItem('token', token);
        const decoded = decodeToken(token);
        setUser({
            token,
            email: decoded.sub,
            role: decoded.role,
            id: decoded.userId,
            name: decoded.name
        });
        return token;
    };

    const logout = () => {
        localStorage.removeItem('token');
        setUser(null);
    };

    return (
        <AuthContext.Provider value={{ user, login, signup, logout, loading }}>
            {!loading && children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => useContext(AuthContext);
