import React from 'react';
import {
    Target,
    Clock,
    CheckCircle2,
    Flame,
    ArrowUpRight
} from 'lucide-react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import Card from '../components/ui/Card';
import Badge from '../components/ui/Badge';
import { useAuth } from '../context/AuthContext';

const Dashboard = () => {
    const { user } = useAuth();
    // Mock Data
    const stats = [
        { label: 'Total Goals', value: '12', icon: Target, color: 'text-blue-600', bg: 'bg-blue-100' },
        { label: 'Hours This Week', value: '24.5', icon: Clock, color: 'text-violet-600', bg: 'bg-violet-100' },
        { label: 'Completed', value: '8', icon: CheckCircle2, color: 'text-green-600', bg: 'bg-green-100' },
        { label: 'Streak', value: '5 Days', icon: Flame, color: 'text-amber-600', bg: 'bg-amber-100' },
    ];

    const chartData = [
        { name: 'Mon', hours: 4 },
        { name: 'Tue', hours: 6 },
        { name: 'Wed', hours: 5 },
        { name: 'Thu', hours: 8 },
        { name: 'Fri', hours: 4.5 },
        { name: 'Sat', hours: 2 },
        { name: 'Sun', hours: 0 },
    ];

    const recentActivity = [
        { id: 1, goal: 'Learn Spring Boot', action: 'Completed session', time: '2 hours ago', duration: '45m' },
        { id: 2, goal: 'React Project', action: 'Added new task', time: '4 hours ago', duration: '-' },
        { id: 3, goal: 'Fitness', action: 'Goal completed', time: 'Yesterday', duration: '-' },
    ];

    return (
        <div className="space-y-8">
            {/* Welcome Section */}
            <div>
                <h1 className="text-3xl font-bold text-slate-900">Welcome back, {user?.name || 'User'} 👋</h1>
                <p className="text-slate-500 mt-2">Here's what's happening with your goals today.</p>
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
                        </div>
                    </Card>
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                {/* Chart Section */}
                <div className="lg:col-span-2">
                    <Card className="h-full">
                        <div className="flex items-center justify-between mb-6">
                            <h3 className="text-lg font-bold text-slate-900">Weekly Activity</h3>
                            <Badge variant="primary">Last 7 Days</Badge>
                        </div>
                        <div className="h-[300px] w-full">
                            <ResponsiveContainer width="100%" height="100%">
                                <LineChart data={chartData}>
                                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
                                    <XAxis
                                        dataKey="name"
                                        axisLine={false}
                                        tickLine={false}
                                        tick={{ fill: '#64748b', fontSize: 12 }}
                                        dy={10}
                                    />
                                    <YAxis
                                        axisLine={false}
                                        tickLine={false}
                                        tick={{ fill: '#64748b', fontSize: 12 }}
                                    />
                                    <Tooltip
                                        contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 4px 20px rgba(0,0,0,0.1)' }}
                                    />
                                    <Line
                                        type="monotone"
                                        dataKey="hours"
                                        stroke="#8b5cf6"
                                        strokeWidth={3}
                                        dot={{ r: 4, fill: '#8b5cf6', strokeWidth: 2, stroke: '#fff' }}
                                        activeDot={{ r: 6, fill: '#8b5cf6' }}
                                    />
                                </LineChart>
                            </ResponsiveContainer>
                        </div>
                    </Card>
                </div>

                {/* Recent Activity */}
                <div>
                    <Card className="h-full">
                        <h3 className="text-lg font-bold text-slate-900 mb-6">Recent Activity</h3>
                        <div className="space-y-6">
                            {recentActivity.map((item) => (
                                <div key={item.id} className="flex items-start gap-4">
                                    <div className="w-8 h-8 rounded-full bg-surface-100 flex items-center justify-center text-slate-500 shrink-0">
                                        <Clock size={16} />
                                    </div>
                                    <div className="flex-1 min-w-0">
                                        <p className="text-sm font-medium text-slate-900 truncate">{item.goal}</p>
                                        <p className="text-xs text-slate-500 mt-0.5">{item.action}</p>
                                    </div>
                                    <div className="text-right">
                                        <p className="text-xs font-medium text-slate-400">{item.time}</p>
                                        {item.duration !== '-' && (
                                            <Badge variant="default" className="mt-1">{item.duration}</Badge>
                                        )}
                                    </div>
                                </div>
                            ))}
                        </div>
                        <button className="w-full mt-6 py-2 text-sm font-medium text-primary-600 hover:text-primary-700 flex items-center justify-center gap-2 transition-colors">
                            View All History
                            <ArrowUpRight size={16} />
                        </button>
                    </Card>
                </div>
            </div>
        </div>
    );
};

export default Dashboard;
