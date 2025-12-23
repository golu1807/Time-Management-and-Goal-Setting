import React, { useState } from 'react';
import { Outlet, NavLink, useNavigate } from 'react-router-dom';
import {
    LayoutDashboard,
    Target,
    Timer,
    BarChart2,
    Settings,
    LogOut,
    Menu,
    X,
    User
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';

const Layout = () => {
    const { logout, user } = useAuth();
    const navigate = useNavigate();
    const [isSidebarOpen, setIsSidebarOpen] = useState(false);

    const handleLogout = () => {
        logout();
        navigate('/login');
    };

    const navItems = [
        { icon: LayoutDashboard, label: 'Dashboard', path: '/dashboard' },
        { icon: Target, label: 'Goals', path: '/goals' },
        { icon: Timer, label: 'Time Tracking', path: '/time-tracking' },
        { icon: BarChart2, label: 'Analytics', path: '/analytics' },
        { icon: Settings, label: 'Settings', path: '/settings' },
        ...(user?.role === 'ADMIN' ? [
            { icon: User, label: 'User Management', path: '/users' },
            { icon: BarChart2, label: 'Admin Analytics', path: '/admin-analytics' }
        ] : []),
    ];

    return (
        <div className="min-h-screen bg-surface-50 flex">
            {/* Sidebar */}
            <aside
                className={`
          fixed inset-y-0 left-0 z-50 w-64 bg-white border-r border-surface-200 transform transition-transform duration-300 ease-in-out
          ${isSidebarOpen ? 'translate-x-0' : '-translate-x-full'}
          md:relative md:translate-x-0
        `}
            >
                <div className="h-full flex flex-col">
                    <div className="p-6 flex items-center justify-between">
                        <h1 className="text-2xl font-bold text-primary-600 flex items-center gap-2">
                            <Timer className="w-8 h-8" />
                            TimeTrack
                        </h1>
                        <button onClick={() => setIsSidebarOpen(false)} className="md:hidden text-slate-500">
                            <X size={24} />
                        </button>
                    </div>

                    <nav className="flex-1 px-4 space-y-2 py-4">
                        {navItems.map((item) => (
                            <NavLink
                                key={item.path}
                                to={item.path}
                                className={({ isActive }) => `
                  flex items-center gap-3 px-4 py-3 rounded-xl transition-colors
                  ${isActive
                                        ? 'bg-primary-50 text-primary-600 font-medium'
                                        : 'text-slate-600 hover:bg-surface-50 hover:text-primary-600'
                                    }
                `}
                            >
                                <item.icon size={20} />
                                {item.label}
                            </NavLink>
                        ))}
                    </nav>

                    <div className="p-4 border-t border-surface-200">
                        <button
                            onClick={handleLogout}
                            className="flex items-center gap-3 px-4 py-3 w-full text-slate-600 hover:bg-red-50 hover:text-red-600 rounded-xl transition-colors"
                        >
                            <LogOut size={20} />
                            Logout
                        </button>
                    </div>
                </div>
            </aside>

            {/* Main Content */}
            <div className="flex-1 flex flex-col min-w-0">
                {/* Header */}
                <header className="bg-white border-b border-surface-200 h-16 flex items-center justify-between px-4 md:px-8 sticky top-0 z-40">
                    <button onClick={() => setIsSidebarOpen(true)} className="md:hidden text-slate-500">
                        <Menu size={24} />
                    </button>

                    <div className="flex items-center gap-4 ml-auto">
                        <div className="flex items-center gap-3 pl-4 border-l border-surface-200">
                            <div className="text-right hidden sm:block">
                                <p className="text-sm font-medium text-slate-900">{user?.name || 'User'}</p>
                                <p className="text-xs text-slate-500">{user?.email || 'user@example.com'}</p>
                            </div>
                            <div className="w-10 h-10 rounded-full bg-primary-100 flex items-center justify-center text-primary-600">
                                <User size={20} />
                            </div>
                        </div>
                    </div>
                </header>

                {/* Page Content */}
                <main className="flex-1 p-4 md:p-8 overflow-y-auto">
                    <Outlet />
                </main>
            </div>
        </div>
    );
};

export default Layout;
