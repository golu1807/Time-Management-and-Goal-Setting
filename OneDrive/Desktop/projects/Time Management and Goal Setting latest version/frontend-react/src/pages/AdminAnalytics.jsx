import React, { useState, useEffect } from 'react';
import { Users, Target, TrendingUp, CheckCircle2 } from 'lucide-react';
import { PieChart, Pie, Cell, ResponsiveContainer, Tooltip } from 'recharts';
import Card from '../components/ui/Card';
import api from '../services/api';
import { useToast } from '../components/ui/Toast';
import { useNavigate } from 'react-router-dom';

const AdminAnalytics = () => {
    const [summary, setSummary] = useState(null);
    const [loading, setLoading] = useState(true);
    const { addToast } = useToast();
    const navigate = useNavigate();

    useEffect(() => {
        fetchSummary();
    }, []);

    const fetchSummary = async () => {
        try {
            const response = await api.get('/admin/usage-summary');
            setSummary(response.data);
        } catch (error) {
            console.error('Failed to fetch summary:', error);
            if (error.response && error.response.status === 403) {
                addToast('Access Denied: Admin only', 'error');
                navigate('/dashboard');
            } else {
                addToast('Failed to load analytics', 'error');
            }
        } finally {
            setLoading(false);
        }
    };

    if (loading) return <div className="flex items-center justify-center h-64"><p className="text-slate-500">Loading...</p></div>;
    if (!summary) return null;

    const goalData = [
        { name: 'In Progress', value: summary.inProgressGoals || 0, color: '#8b5cf6' },
        { name: 'Completed', value: summary.completedGoals || 0, color: '#10b981' },
    ];

    const stats = [
        {
            label: 'Total Users',
            value: summary.totalUsers,
            icon: Users,
            color: 'text-blue-600',
            bg: 'bg-blue-100',
            subtext: `${summary.activeUsers} active`
        },
        {
            label: 'Total Goals',
            value: summary.totalGoals,
            icon: Target,
            color: 'text-violet-600',
            bg: 'bg-violet-100',
            subtext: `${summary.completedGoals} completed`
        },
        {
            label: 'Completion Rate',
            value: summary.totalGoals > 0 ? `${Math.round((summary.completedGoals / summary.totalGoals) * 100)}%` : '0%',
            icon: CheckCircle2,
            color: 'text-green-600',
            bg: 'bg-green-100',
            subtext: 'Overall success'
        },
        {
            label: 'Active Users',
            value: summary.activeUsers,
            icon: TrendingUp,
            color: 'text-amber-600',
            bg: 'bg-amber-100',
            subtext: `${Math.round((summary.activeUsers / summary.totalUsers) * 100)}% of total`
        },
    ];

    return (
        <div className="space-y-8">
            <div>
                <h1 className="text-3xl font-bold text-slate-900">Admin Analytics</h1>
                <p className="text-slate-500 mt-2">Platform-wide usage insights and metrics.</p>
            </div>

            {/* KPI Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                {stats.map((stat, index) => (
                    <Card key={index} hover className="flex items-center gap-4">
                        <div className={`p-3 rounded-xl ${stat.bg} ${stat.color}`}>
                            <stat.icon size={24} />
                        </div>
                        <div>
                            <p className="text-sm font-medium text-slate-500">{stat.label}</p>
                            <h3 className="text-2xl font-bold text-slate-900">{stat.value}</h3>
                            <p className="text-xs text-slate-400 mt-1">{stat.subtext}</p>
                        </div>
                    </Card>
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                {/* Goal Distribution Chart */}
                <Card>
                    <h3 className="text-lg font-bold text-slate-900 mb-6">Goal Distribution</h3>
                    <div className="h-[300px] w-full flex items-center justify-center">
                        <ResponsiveContainer width="100%" height="100%">
                            <PieChart>
                                <Pie
                                    data={goalData}
                                    innerRadius={60}
                                    outerRadius={100}
                                    paddingAngle={5}
                                    dataKey="value"
                                >
                                    {goalData.map((entry, index) => (
                                        <Cell key={`cell-${index}`} fill={entry.color} />
                                    ))}
                                </Pie>
                                <Tooltip />
                            </PieChart>
                        </ResponsiveContainer>
                    </div>
                    <div className="space-y-3 mt-4">
                        {goalData.map((item) => (
                            <div key={item.name} className="flex items-center justify-between">
                                <div className="flex items-center gap-2">
                                    <div className="w-3 h-3 rounded-full" style={{ backgroundColor: item.color }} />
                                    <span className="text-sm text-slate-600">{item.name}</span>
                                </div>
                                <span className="text-sm font-medium text-slate-900">{item.value}</span>
                            </div>
                        ))}
                    </div>
                </Card>

                {/* Quick Stats */}
                <Card>
                    <h3 className="text-lg font-bold text-slate-900 mb-6">Platform Health</h3>
                    <div className="space-y-6">
                        <div className="flex justify-between items-center pb-4 border-b border-surface-100">
                            <span className="text-sm text-slate-600">User Engagement</span>
                            <span className="text-lg font-bold text-green-600">
                                {Math.round((summary.activeUsers / summary.totalUsers) * 100)}%
                            </span>
                        </div>
                        <div className="flex justify-between items-center pb-4 border-b border-surface-100">
                            <span className="text-sm text-slate-600">Goal Success Rate</span>
                            <span className="text-lg font-bold text-purple-600">
                                {summary.totalGoals > 0 ? Math.round((summary.completedGoals / summary.totalGoals) * 100) : 0}%
                            </span>
                        </div>
                        <div className="flex justify-between items-center pb-4 border-b border-surface-100">
                            <span className="text-sm text-slate-600">Active Goals</span>
                            <span className="text-lg font-bold text-blue-600">{summary.inProgressGoals}</span>
                        </div>
                        <div className="flex justify-between items-center">
                            <span className="text-sm text-slate-600">Inactive Users</span>
                            <span className="text-lg font-bold text-slate-400">{summary.totalUsers - summary.activeUsers}</span>
                        </div>
                    </div>
                </Card>
            </div>
        </div>
    );
};

export default AdminAnalytics;
