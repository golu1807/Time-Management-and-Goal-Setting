import React, { useState, useEffect } from 'react';
import {
    Play,
    Pause,
    Square,
    History,
    Tag,
    Clock
} from 'lucide-react';
import Card from '../components/ui/Card';
import Button from '../components/ui/Button';
import Badge from '../components/ui/Badge';

const TimeTracking = () => {
    const [isActive, setIsActive] = useState(false);
    const [time, setTime] = useState(0);
    const [selectedGoal, setSelectedGoal] = useState('');

    useEffect(() => {
        let interval = null;
        if (isActive) {
            interval = setInterval(() => {
                setTime((time) => time + 1);
            }, 1000);
        } else if (!isActive && time !== 0) {
            clearInterval(interval);
        }
        return () => clearInterval(interval);
    }, [isActive, time]);

    const formatTime = (seconds) => {
        const h = Math.floor(seconds / 3600);
        const m = Math.floor((seconds % 3600) / 60);
        const s = seconds % 60;
        return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
    };

    const handleStart = () => setIsActive(true);
    const handlePause = () => setIsActive(false);
    const handleStop = () => {
        setIsActive(false);
        setTime(0);
    };

    // Mock Data
    const sessionLog = [
        { id: 1, goal: 'Learn Spring Boot', startTime: '10:00 AM', endTime: '11:30 AM', duration: '1h 30m', tag: 'Deep Work' },
        { id: 2, goal: 'React Project', startTime: '02:00 PM', endTime: '03:15 PM', duration: '1h 15m', tag: 'Coding' },
        { id: 3, goal: 'Email & Admin', startTime: '04:30 PM', endTime: '05:00 PM', duration: '30m', tag: 'Admin' },
    ];

    return (
        <div className="space-y-8">
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                {/* Main Timer Section */}
                <div className="lg:col-span-2 space-y-6">
                    <Card className="flex flex-col items-center justify-center py-16 text-center relative overflow-hidden">
                        {/* Background decoration */}
                        <div className="absolute inset-0 bg-primary-50/50 -z-10" />
                        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-primary-300 via-primary-500 to-primary-300" />

                        <div className="mb-8">
                            <h2 className="text-sm font-medium text-slate-500 uppercase tracking-wider mb-2">Current Session</h2>
                            <div className="text-7xl md:text-9xl font-bold text-slate-900 font-mono tracking-tight">
                                {formatTime(time)}
                            </div>
                        </div>

                        <div className="w-full max-w-md space-y-6">
                            <div className="grid grid-cols-2 gap-4">
                                <select
                                    className="w-full p-3 rounded-xl border border-surface-200 bg-white focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 outline-none transition-all"
                                    value={selectedGoal}
                                    onChange={(e) => setSelectedGoal(e.target.value)}
                                >
                                    <option value="">Select Goal...</option>
                                    <option value="1">Learn Spring Boot</option>
                                    <option value="2">React Project</option>
                                </select>
                                <select className="w-full p-3 rounded-xl border border-surface-200 bg-white focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 outline-none transition-all">
                                    <option value="">Select Tag...</option>
                                    <option value="deep">Deep Work</option>
                                    <option value="focus">Focus</option>
                                    <option value="pomodoro">Pomodoro</option>
                                </select>
                            </div>

                            <div className="flex items-center justify-center gap-4">
                                {!isActive ? (
                                    <Button
                                        variant="primary"
                                        size="lg"
                                        className="w-32 h-16 rounded-2xl text-xl shadow-xl shadow-primary-500/20 hover:shadow-primary-500/40 hover:-translate-y-1 transition-all"
                                        onClick={handleStart}
                                    >
                                        <Play fill="currentColor" className="mr-2" /> Start
                                    </Button>
                                ) : (
                                    <Button
                                        variant="secondary"
                                        size="lg"
                                        className="w-32 h-16 rounded-2xl text-xl"
                                        onClick={handlePause}
                                    >
                                        <Pause fill="currentColor" className="mr-2" /> Pause
                                    </Button>
                                )}
                                <Button
                                    variant="danger"
                                    size="lg"
                                    className="w-16 h-16 rounded-2xl flex items-center justify-center"
                                    onClick={handleStop}
                                    disabled={time === 0}
                                >
                                    <Square fill="currentColor" />
                                </Button>
                            </div>
                        </div>
                    </Card>

                    {/* Daily Summary */}
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <Card className="p-4 flex items-center gap-4">
                            <div className="p-3 bg-blue-100 text-blue-600 rounded-xl">
                                <Clock size={24} />
                            </div>
                            <div>
                                <p className="text-sm text-slate-500">Today's Total</p>
                                <p className="text-xl font-bold text-slate-900">3h 15m</p>
                            </div>
                        </Card>
                        <Card className="p-4 flex items-center gap-4">
                            <div className="p-3 bg-violet-100 text-violet-600 rounded-xl">
                                <Tag size={24} />
                            </div>
                            <div>
                                <p className="text-sm text-slate-500">Top Tag</p>
                                <p className="text-xl font-bold text-slate-900">Deep Work</p>
                            </div>
                        </Card>
                        <Card className="p-4 flex items-center gap-4">
                            <div className="p-3 bg-green-100 text-green-600 rounded-xl">
                                <History size={24} />
                            </div>
                            <div>
                                <p className="text-sm text-slate-500">Sessions</p>
                                <p className="text-xl font-bold text-slate-900">3</p>
                            </div>
                        </Card>
                    </div>
                </div>

                {/* Session Log */}
                <div className="lg:col-span-1">
                    <Card className="h-full">
                        <div className="flex items-center justify-between mb-6">
                            <h3 className="text-lg font-bold text-slate-900">Session Log</h3>
                            <Button variant="ghost" size="sm">View All</Button>
                        </div>

                        <div className="space-y-4">
                            {sessionLog.map((session) => (
                                <div key={session.id} className="p-4 rounded-xl bg-surface-50 border border-surface-100 hover:border-primary-200 transition-colors group">
                                    <div className="flex justify-between items-start mb-2">
                                        <h4 className="font-medium text-slate-900">{session.goal}</h4>
                                        <Badge variant="primary">{session.duration}</Badge>
                                    </div>
                                    <div className="flex items-center justify-between text-sm text-slate-500">
                                        <div className="flex items-center gap-2">
                                            <Clock size={14} />
                                            {session.startTime} - {session.endTime}
                                        </div>
                                        <span className="text-xs px-2 py-1 rounded-md bg-white border border-surface-200 group-hover:border-primary-200 transition-colors">
                                            {session.tag}
                                        </span>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </Card>
                </div>
            </div>
        </div>
    );
};

export default TimeTracking;
