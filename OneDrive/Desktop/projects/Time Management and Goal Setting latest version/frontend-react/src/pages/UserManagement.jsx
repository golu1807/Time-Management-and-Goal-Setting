import React, { useState, useEffect } from 'react';
import {
    Search,
    Shield,
    User,
    Lock,
    Unlock
} from 'lucide-react';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import api from '../services/api';
import { useToast } from '../components/ui/Toast';
import { useNavigate } from 'react-router-dom';

const UserManagement = () => {
    const [search, setSearch] = useState('');
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);
    const [roleFilter, setRoleFilter] = useState('');
    const [statusFilter, setStatusFilter] = useState('');
    const [selectedUser, setSelectedUser] = useState(null);
    const { addToast } = useToast();
    const navigate = useNavigate();

    useEffect(() => {
        fetchUsers();
    }, [roleFilter, statusFilter, search]);

    const fetchUsers = async () => {
        try {
            const params = {};
            if (roleFilter) params.role = roleFilter;
            if (statusFilter) params.status = statusFilter;
            if (search) params.q = search;

            const response = await api.get('/users', { params });
            setUsers(response.data);
        } catch (error) {
            console.error('Failed to fetch users:', error);
            if (error.response && error.response.status === 403) {
                addToast('Access Denied: Admin only', 'error');
                navigate('/dashboard');
            } else {
                addToast('Failed to load users', 'error');
            }
        } finally {
            setLoading(false);
        }
    };

    const handleStatusChange = async (userId, currentStatus) => {
        const newStatus = currentStatus === 'ACTIVE' ? 'LOCKED' : 'ACTIVE';
        try {
            await api.put(`/users/${userId}/status`, { status: newStatus });
            addToast(`User ${newStatus.toLowerCase()} successfully`, 'success');
            fetchUsers();
        } catch (error) {
            addToast('Failed to update status', 'error');
        }
    };

    const handleRoleChange = async (userId, currentRole) => {
        const newRole = currentRole === 'ADMIN' ? 'USER' : 'ADMIN';
        if (!window.confirm(`Are you sure you want to change role to ${newRole}?`)) return;

        try {
            await api.put(`/users/${userId}/role`, { role: newRole });
            addToast(`User role updated to ${newRole}`, 'success');
            fetchUsers();
        } catch (error) {
            addToast('Failed to update role', 'error');
        }
    };

    if (loading) return <div className="flex items-center justify-center h-64"><p className="text-slate-500">Loading...</p></div>;

    return (
        <div className="space-y-8">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h1 className="text-3xl font-bold text-slate-900">User Management</h1>
                    <p className="text-slate-500 mt-2">Manage user access and roles.</p>
                </div>
            </div>

            <Card className="overflow-hidden">
                {/* Toolbar */}
                <div className="p-4 border-b border-surface-100 flex flex-col md:flex-row gap-4 justify-between items-center">
                    <div className="relative w-full md:w-96">
                        <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
                        <input
                            type="text"
                            placeholder="Search users..."
                            className="w-full pl-10 pr-4 py-2 rounded-xl border border-surface-200 focus:outline-none focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 transition-all"
                            value={search}
                            onChange={(e) => setSearch(e.target.value)}
                        />
                    </div>
                    <div className="flex gap-2">
                        <select
                            className="px-4 py-2 rounded-xl border border-surface-200 bg-white text-sm"
                            value={roleFilter}
                            onChange={(e) => setRoleFilter(e.target.value)}
                        >
                            <option value="">All Roles</option>
                            <option value="ADMIN">Admin</option>
                            <option value="USER">User</option>
                        </select>
                        <select
                            className="px-4 py-2 rounded-xl border border-surface-200 bg-white text-sm"
                            value={statusFilter}
                            onChange={(e) => setStatusFilter(e.target.value)}
                        >
                            <option value="">All Status</option>
                            <option value="ACTIVE">Active</option>
                            <option value="LOCKED">Locked</option>
                        </select>
                    </div>
                </div>

                {/* Table */}
                <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse">
                        <thead>
                            <tr className="bg-surface-50 border-b border-surface-100">
                                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">User</th>
                                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Role</th>
                                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
                                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-surface-100">
                            {users.map((user) => (
                                <tr key={user.id} className="hover:bg-surface-50 transition-colors">
                                    <td className="px-6 py-4">
                                        <div className="flex items-center gap-3">
                                            <div className="w-10 h-10 rounded-full bg-primary-100 flex items-center justify-center text-primary-600 font-bold cursor-pointer" onClick={() => setSelectedUser(user)}>
                                                {user.name.charAt(0)}
                                            </div>
                                            <div>
                                                <p className="text-sm font-medium text-slate-900 cursor-pointer hover:text-primary-600" onClick={() => setSelectedUser(user)}>{user.name}</p>
                                                <p className="text-xs text-slate-500">{user.email}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td className="px-6 py-4">
                                        <div className="flex items-center gap-2">
                                            {user.role === 'ADMIN' ? <Shield size={14} className="text-primary-600" /> : <User size={14} className="text-slate-400" />}
                                            <span className="text-sm text-slate-700">{user.role}</span>
                                        </div>
                                    </td>
                                    <td className="px-6 py-4">
                                        <Badge variant={user.status === 'ACTIVE' ? 'success' : 'danger'}>
                                            {user.status}
                                        </Badge>
                                    </td>
                                    <td className="px-6 py-4 text-right">
                                        <div className="flex justify-end gap-2">
                                            <button
                                                onClick={() => handleStatusChange(user.id, user.status)}
                                                className="p-2 text-slate-400 hover:text-slate-600 hover:bg-surface-200 rounded-lg transition-colors"
                                                title={user.status === 'ACTIVE' ? 'Lock User' : 'Unlock User'}
                                            >
                                                {user.status === 'ACTIVE' ? <Lock size={18} /> : <Unlock size={18} />}
                                            </button>
                                            <button
                                                onClick={() => handleRoleChange(user.id, user.role)}
                                                className="p-2 text-slate-400 hover:text-slate-600 hover:bg-surface-200 rounded-lg transition-colors"
                                                title="Change Role"
                                            >
                                                <Shield size={18} />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </Card>

            {/* Profile Panel */}
            {selectedUser && (
                <div className="fixed inset-0 z-50 flex justify-end" onClick={() => setSelectedUser(null)}>
                    <div className="absolute inset-0 bg-slate-900/50 backdrop-blur-sm" />
                    <div
                        className="relative bg-white w-96 h-full shadow-2xl overflow-y-auto"
                        onClick={(e) => e.stopPropagation()}
                    >
                        <div className="p-6 border-b border-surface-100 sticky top-0 bg-white z-10">
                            <div className="flex items-center justify-between mb-4">
                                <h3 className="text-xl font-bold text-slate-900">User Profile</h3>
                                <button onClick={() => setSelectedUser(null)} className="text-slate-400 hover:text-slate-600">
                                    <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                                    </svg>
                                </button>
                            </div>
                            <div className="flex items-center gap-4">
                                <div className="w-16 h-16 rounded-full bg-primary-100 flex items-center justify-center text-primary-600 font-bold text-2xl">
                                    {selectedUser.name.charAt(0)}
                                </div>
                                <div>
                                    <p className="text-lg font-bold text-slate-900">{selectedUser.name}</p>
                                    <p className="text-sm text-slate-500">{selectedUser.email}</p>
                                </div>
                            </div>
                        </div>

                        <div className="p-6 space-y-6">
                            <div>
                                <h4 className="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-3">Account Details</h4>
                                <div className="space-y-3">
                                    <div className="flex justify-between items-center">
                                        <span className="text-sm text-slate-600">Role</span>
                                        <Badge variant={selectedUser.role === 'ADMIN' ? 'primary' : 'default'}>
                                            {selectedUser.role}
                                        </Badge>
                                    </div>
                                    <div className="flex justify-between items-center">
                                        <span className="text-sm text-slate-600">Status</span>
                                        <Badge variant={selectedUser.status === 'ACTIVE' ? 'success' : 'danger'}>
                                            {selectedUser.status}
                                        </Badge>
                                    </div>
                                    <div className="flex justify-between items-center">
                                        <span className="text-sm text-slate-600">User ID</span>
                                        <span className="text-sm font-mono text-slate-900">#{selectedUser.id}</span>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <h4 className="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-3">Actions</h4>
                                <div className="space-y-2">
                                    <button
                                        onClick={() => { handleRoleChange(selectedUser.id, selectedUser.role); setSelectedUser(null); }}
                                        className="w-full px-4 py-2 text-left text-sm rounded-lg hover:bg-surface-50 transition-colors flex items-center gap-2"
                                    >
                                        <Shield size={16} />
                                        Change Role
                                    </button>
                                    <button
                                        onClick={() => { handleStatusChange(selectedUser.id, selectedUser.status); setSelectedUser(null); }}
                                        className="w-full px-4 py-2 text-left text-sm rounded-lg hover:bg-surface-50 transition-colors flex items-center gap-2"
                                    >
                                        {selectedUser.status === 'ACTIVE' ? <Lock size={16} /> : <Unlock size={16} />}
                                        {selectedUser.status === 'ACTIVE' ? 'Lock User' : 'Unlock User'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default UserManagement;
