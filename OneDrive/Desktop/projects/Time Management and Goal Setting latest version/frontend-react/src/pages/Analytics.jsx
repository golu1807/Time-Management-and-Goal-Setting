import React from 'react';
import {
    Users,
    Clock,
    Calendar,
    TrendingUp,
    Download
} from 'lucide-react';
import {
    LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer,
    PieChart, Pie, Cell
} from 'recharts';
import Card from '../components/ui/Card';
import Button from '../components/ui/Button';

const Analytics = () => {
    // Mock Data
    const engagementData = [
        { name: 'Mon', hours: 4, sessions: 3 },
        { name: 'Tue', hours: 6, sessions: 5 },
        { name: 'Wed', hours: 5, sessions: 4 },
        { name: 'Thu', hours: 8, sessions: 6 },
        { name: 'Fri', hours: 4.5, sessions: 3 },
        { name: 'Sat', hours: 2, sessions: 1 },
        { name: 'Sun', hours: 1, sessions: 1 },
    ];

    const goalDistribution = [
        { name: 'Work', value: 65, color: '#8b5cf6' },
        { name: 'Personal', value: 25, color: '#10b981' },
        { name: 'Learning', value: 10, color: '#f59e0b' },
    ];

    return (
        <div className="space-y-8">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h1 className="text-3xl font-bold text-slate-900">Analytics</h1>
                    <p className="text-slate-500 mt-2">Deep insights into your productivity.</p>
                </div>
                <div className="flex gap-2">
                    <select className="px-4 py-2 rounded-xl border border-surface-200 bg-white focus:outline-none focus:ring-2 focus:ring-primary-500/20">
                        <option>Last 7 Days</option>
                        <option>Last 30 Days</option>
                        <option>This Year</option>
                    </select>
                    <Button variant="secondary" className="flex items-center gap-2">
                        <Download size={18} /> Export
                    </Button>
                </div>
            </div>

            {/* Top KPIs */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                <Card className="p-4">
                    <div className="flex items-center gap-3 mb-2">
                        <div className="p-2 bg-blue-100 text-blue-600 rounded-lg">
                            <Users size={20} />
                        </div>
                        <span className="text-sm font-medium text-slate-500">Active Users</span>
                    </div>
                    <p className="text-2xl font-bold text-slate-900">1,234</p>
                    <p className="text-xs text-green-600 flex items-center mt-1">
                        <TrendingUp size={12} className="mr-1" /> +12% vs last week
                    </p>
                </Card>
                <Card className="p-4">
                    <div className="flex items-center gap-3 mb-2">
                        <div className="p-2 bg-violet-100 text-violet-600 rounded-lg">
                            <Clock size={20} />
                        </div>
                        <span className="text-sm font-medium text-slate-500">Avg Session</span>
                    </div>
                    <p className="text-2xl font-bold text-slate-900">45m</p>
                    <p className="text-xs text-green-600 flex items-center mt-1">
                        <TrendingUp size={12} className="mr-1" /> +5% vs last week
                    </p>
                </Card>
                <Card className="p-4">
                    <div className="flex items-center gap-3 mb-2">
                        <div className="p-2 bg-amber-100 text-amber-600 rounded-lg">
                            <Calendar size={20} />
                        </div>
                        <span className="text-sm font-medium text-slate-500">Weekly Hours</span>
                    </div>
                    <p className="text-2xl font-bold text-slate-900">32.5h</p>
                    <p className="text-xs text-red-600 flex items-center mt-1">
                        <TrendingUp size={12} className="mr-1 rotate-180" /> -2% vs last week
                    </p>
                </Card>
                <Card className="p-4">
                    <div className="flex items-center gap-3 mb-2">
                        <div className="p-2 bg-green-100 text-green-600 rounded-lg">
                            <TrendingUp size={20} />
                        </div>
                        <span className="text-sm font-medium text-slate-500">Top Goal</span>
                    </div>
                    <p className="text-lg font-bold text-slate-900 truncate">Spring Boot</p>
                    <p className="text-xs text-slate-400 mt-1">12 hours logged</p>
                </Card>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                {/* Main Chart */}
                <div className="lg:col-span-2">
                    <Card className="h-full">
                        <h3 className="text-lg font-bold text-slate-900 mb-6">Engagement Over Time</h3>
                        <div className="h-[350px] w-full">
                            <ResponsiveContainer width="100%" height="100%">
                                <LineChart data={engagementData}>
                                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
                                    <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{ fill: '#64748b' }} dy={10} />
                                    <YAxis axisLine={false} tickLine={false} tick={{ fill: '#64748b' }} />
                                    <Tooltip contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 4px 20px rgba(0,0,0,0.1)' }} />
                                    <Line type="monotone" dataKey="hours" stroke="#8b5cf6" strokeWidth={3} dot={{ r: 4, fill: '#8b5cf6', stroke: '#fff', strokeWidth: 2 }} />
                                    <Line type="monotone" dataKey="sessions" stroke="#10b981" strokeWidth={3} dot={{ r: 4, fill: '#10b981', stroke: '#fff', strokeWidth: 2 }} />
                                </LineChart>
                            </ResponsiveContainer>
                        </div>
                    </Card>
                </div>

                {/* Distribution Chart */}
                <div>
                    <Card className="h-full">
                        <h3 className="text-lg font-bold text-slate-900 mb-6">Time Distribution</h3>
                        <div className="h-[300px] w-full flex items-center justify-center">
                            <ResponsiveContainer width="100%" height="100%">
                                <PieChart>
                                    <Pie
                                        data={goalDistribution}
                                        innerRadius={60}
                                        outerRadius={80}
                                        paddingAngle={5}
                                        dataKey="value"
                                    >
                                        {goalDistribution.map((entry, index) => (
                                            <Cell key={`cell-${index}`} fill={entry.color} />
                                        ))}
                                    </Pie>
                                    <Tooltip />
                                </PieChart>
                            </ResponsiveContainer>
                        </div>
                        <div className="space-y-3 mt-4">
                            {goalDistribution.map((item) => (
                                <div key={item.name} className="flex items-center justify-between">
                                    <div className="flex items-center gap-2">
                                        <div className="w-3 h-3 rounded-full" style={{ backgroundColor: item.color }} />
                                        <span className="text-sm text-slate-600">{item.name}</span>
                                    </div>
                                    <span className="text-sm font-medium text-slate-900">{item.value}%</span>
                                </div>
                            ))}
                        </div>
                    </Card>
                </div>
            </div>
        </div>
    );
};

export default Analytics;
