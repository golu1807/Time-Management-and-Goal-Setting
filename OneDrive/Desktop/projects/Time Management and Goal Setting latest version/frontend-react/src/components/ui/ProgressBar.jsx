import React from 'react';

const ProgressBar = ({ value, max = 100, color = 'primary', className = '' }) => {
    const percentage = Math.min(100, Math.max(0, (value / max) * 100));

    const colors = {
        primary: "bg-primary-500",
        success: "bg-green-500",
        warning: "bg-amber-500",
        danger: "bg-red-500",
    };

    return (
        <div className={`w-full bg-surface-100 rounded-full h-2.5 overflow-hidden ${className}`}>
            <div
                className={`h-full rounded-full transition-all duration-500 ease-out ${colors[color]}`}
                style={{ width: `${percentage}%` }}
            />
        </div>
    );
};

export default ProgressBar;
