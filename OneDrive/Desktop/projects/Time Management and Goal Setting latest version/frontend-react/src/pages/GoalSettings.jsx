import React from 'react';
import {
    Settings,
    Save,
    Plus
} from 'lucide-react';
import Card from '../components/ui/Card';
import Button from '../components/ui/Button';

const GoalSettings = () => {
    return (
        <div className="space-y-8">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h1 className="text-3xl font-bold text-slate-900">Goal Settings</h1>
                    <p className="text-slate-500 mt-2">Configure goal types and defaults.</p>
                </div>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                {/* Create Form */}
                <div className="lg:col-span-1">
                    <Card>
                        <h3 className="text-lg font-bold text-slate-900 mb-6 flex items-center gap-2">
                            <Plus size={20} className="text-primary-600" />
                            Create Goal Type
                        </h3>
                        <form className="space-y-4">
                            <div>
                                <label className="block text-sm font-medium text-slate-700 mb-1">Type Name</label>
                                <input
                                    type="text"
                                    className="w-full p-2.5 rounded-xl border border-surface-200 focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 outline-none"
                                    placeholder="e.g., Coding"
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium text-slate-700 mb-1">Unit Type</label>
                                <select className="w-full p-2.5 rounded-xl border border-surface-200 focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 outline-none bg-white">
                                    <option>Hours</option>
                                    <option>Sessions</option>
                                    <option>Checklist</option>
                                </select>
                            </div>
                            <div>
                                <label className="block text-sm font-medium text-slate-700 mb-1">Default Color</label>
                                <div className="flex gap-2">
                                    {['#8b5cf6', '#10b981', '#f59e0b', '#ef4444', '#3b82f6'].map(color => (
                                        <button
                                            key={color}
                                            type="button"
                                            className="w-8 h-8 rounded-full border-2 border-white shadow-sm hover:scale-110 transition-transform"
                                            style={{ backgroundColor: color }}
                                        />
                                    ))}
                                </div>
                            </div>
                            <div className="pt-4">
                                <Button variant="primary" className="w-full">
                                    Create Type
                                </Button>
                            </div>
                        </form>
                    </Card>
                </div>

                {/* Existing Types List */}
                <div className="lg:col-span-2">
                    <Card>
                        <h3 className="text-lg font-bold text-slate-900 mb-6">Existing Goal Types</h3>
                        <div className="space-y-4">
                            {[
                                { name: 'Work', unit: 'Hours', color: '#8b5cf6', count: 12 },
                                { name: 'Personal', unit: 'Checklist', color: '#10b981', count: 5 },
                                { name: 'Learning', unit: 'Sessions', color: '#f59e0b', count: 8 },
                            ].map((type) => (
                                <div key={type.name} className="flex items-center justify-between p-4 rounded-xl border border-surface-100 hover:border-primary-200 transition-colors bg-surface-50">
                                    <div className="flex items-center gap-4">
                                        <div className="w-4 h-4 rounded-full" style={{ backgroundColor: type.color }} />
                                        <div>
                                            <h4 className="font-medium text-slate-900">{type.name}</h4>
                                            <p className="text-xs text-slate-500">{type.unit} • {type.count} active goals</p>
                                        </div>
                                    </div>
                                    <div className="flex gap-2">
                                        <Button variant="ghost" size="sm">Edit</Button>
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

export default GoalSettings;
