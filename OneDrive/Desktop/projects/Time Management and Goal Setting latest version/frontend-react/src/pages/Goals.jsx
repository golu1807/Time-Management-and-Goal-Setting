import React, { useState, useEffect } from 'react';
import {
    Plus,
    Search,
    MoreVertical,
    Calendar,
    CheckCircle2
} from 'lucide-react';
import Card from '../components/ui/Card';
import Button from '../components/ui/Button';
import Badge from '../components/ui/Badge';
import ProgressBar from '../components/ui/ProgressBar';
import Modal from '../components/ui/Modal';
import Input from '../components/ui/Input';
import { useToast } from '../components/ui/Toast';
import api from '../services/api';

const Goals = () => {
    const [filter, setFilter] = useState('all');
    const [search, setSearch] = useState('');
    const [goals, setGoals] = useState([]);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [isLoading, setIsLoading] = useState(false);
    const [formData, setFormData] = useState({
        title: '',
        description: '',
        targetHours: '',
        deadline: '',
        category: 'Personal' // Default
    });

    const { addToast } = useToast();

    useEffect(() => {
        fetchGoals();
    }, []);

    const fetchGoals = async () => {
        try {
            const response = await api.get('/goals');
            setGoals(response.data);
        } catch (error) {
            console.error('Failed to fetch goals:', error);
            // addToast('Failed to load goals', 'error');
        }
    };

    const handleCreateGoal = async (e) => {
        e.preventDefault();
        setIsLoading(true);

        try {
            // Basic validation
            if (!formData.title || !formData.targetHours || !formData.deadline) {
                addToast('Please fill in all required fields', 'error');
                setIsLoading(false);
                return;
            }

            await api.post('/goals', {
                ...formData,
                status: 'IN_PROGRESS',
                targetHours: parseFloat(formData.targetHours)
            });

            addToast('Goal created successfully', 'success');
            setIsModalOpen(false);
            setFormData({ title: '', description: '', targetHours: '', deadline: '', category: 'Personal' });
            fetchGoals(); // Refresh list
        } catch (error) {
            console.error('Create goal error:', error);
            addToast('Failed to create goal', 'error');
        } finally {
            setIsLoading(false);
        }
    };

    const filteredGoals = goals.filter(goal => {
        const matchesFilter = filter === 'all' ||
            (filter === 'active' && goal.status === 'IN_PROGRESS') ||
            (filter === 'completed' && goal.status === 'COMPLETED') ||
            (filter === 'work' && goal.category === 'Work') || // Assuming category field exists or logic needs adjustment
            (filter === 'personal' && goal.category === 'Personal');

        const matchesSearch = goal.title.toLowerCase().includes(search.toLowerCase());

        return matchesFilter && matchesSearch;
    });

    return (
        <div className="space-y-8">
            {/* Header */}
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h1 className="text-3xl font-bold text-slate-900">Goals</h1>
                    <p className="text-slate-500 mt-2">Manage your targets and track progress.</p>
                </div>
                <Button
                    variant="primary"
                    className="flex items-center gap-2"
                    onClick={() => setIsModalOpen(true)}
                >
                    <Plus size={20} />
                    Add New Goal
                </Button>
            </div>

            {/* Filters & Search */}
            <Card className="flex flex-col md:flex-row gap-4 items-center justify-between p-4">
                <div className="relative w-full md:w-96">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={20} />
                    <input
                        type="text"
                        placeholder="Search goals..."
                        className="w-full pl-10 pr-4 py-2 rounded-xl border border-surface-200 focus:outline-none focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 transition-all"
                        value={search}
                        onChange={(e) => setSearch(e.target.value)}
                    />
                </div>

                <div className="flex items-center gap-2 w-full md:w-auto overflow-x-auto pb-2 md:pb-0">
                    {['all', 'active', 'completed'].map((f) => (
                        <button
                            key={f}
                            onClick={() => setFilter(f)}
                            className={`
                px-4 py-2 rounded-xl text-sm font-medium capitalize whitespace-nowrap transition-colors
                ${filter === f
                                    ? 'bg-primary-100 text-primary-700'
                                    : 'text-slate-600 hover:bg-surface-100'
                                }
              `}
                        >
                            {f}
                        </button>
                    ))}
                </div>
            </Card>

            {/* Goals Grid */}
            {filteredGoals.length === 0 ? (
                <div className="text-center py-12">
                    <p className="text-slate-500">No goals found. Create one to get started!</p>
                </div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {filteredGoals.map((goal) => (
                        <Card key={goal.id} hover className="flex flex-col h-full">
                            <div className="flex items-start justify-between mb-4">
                                <Badge variant={goal.status === 'IN_PROGRESS' ? 'primary' : 'success'}>
                                    {goal.status}
                                </Badge>
                                <button className="text-slate-400 hover:text-slate-600">
                                    <MoreVertical size={20} />
                                </button>
                            </div>

                            <h3 className="text-xl font-bold text-slate-900 mb-2">{goal.title}</h3>
                            <p className="text-sm text-slate-500 mb-4 line-clamp-2">{goal.description}</p>

                            <div className="flex items-center gap-4 text-sm text-slate-500 mb-6">
                                {goal.deadline && (
                                    <div className="flex items-center gap-1">
                                        <Calendar size={16} />
                                        {new Date(goal.deadline).toLocaleDateString()}
                                    </div>
                                )}
                                <div className="flex items-center gap-1">
                                    <CheckCircle2 size={16} />
                                    {goal.targetHours} Hours
                                </div>
                            </div>

                            <div className="mt-auto space-y-2">
                                {/* Progress bar logic would go here based on actual tracked time */}
                                <div className="flex justify-between text-sm font-medium">
                                    <span className="text-slate-600">Progress</span>
                                    <span className="text-primary-600">0%</span>
                                </div>
                                <ProgressBar value={0} />
                            </div>
                        </Card>
                    ))}
                </div>
            )}

            {/* Create Goal Modal */}
            <Modal
                isOpen={isModalOpen}
                onClose={() => setIsModalOpen(false)}
                title="Create New Goal"
            >
                <form onSubmit={handleCreateGoal} className="space-y-4">
                    <Input
                        label="Goal Title"
                        value={formData.title}
                        onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                        placeholder="e.g., Learn React"
                        required
                    />

                    <div>
                        <label className="block text-sm font-medium text-slate-700 mb-1">Description</label>
                        <textarea
                            className="w-full px-4 py-2 rounded-xl border border-surface-200 focus:outline-none focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 transition-all bg-white text-slate-900 placeholder-slate-400"
                            rows="3"
                            value={formData.description}
                            onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                            placeholder="What do you want to achieve?"
                        />
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                        <Input
                            type="number"
                            label="Target Hours"
                            value={formData.targetHours}
                            onChange={(e) => setFormData({ ...formData, targetHours: e.target.value })}
                            placeholder="10"
                            required
                        />
                        <Input
                            type="date"
                            label="Deadline"
                            value={formData.deadline}
                            onChange={(e) => setFormData({ ...formData, deadline: e.target.value })}
                            required
                        />
                    </div>

                    <div className="pt-4 flex justify-end gap-3">
                        <Button
                            variant="ghost"
                            onClick={() => setIsModalOpen(false)}
                            type="button"
                        >
                            Cancel
                        </Button>
                        <Button
                            variant="primary"
                            type="submit"
                            disabled={isLoading}
                        >
                            {isLoading ? 'Creating...' : 'Create Goal'}
                        </Button>
                    </div>
                </form>
            </Modal>
        </div>
    );
};

export default Goals;
