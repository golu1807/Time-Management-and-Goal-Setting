import React from 'react';

const Input = ({
    type = 'text',
    label,
    id,
    value,
    onChange,
    placeholder,
    required = false,
    className = ''
}) => {
    return (
        <div className={className}>
            {label && (
                <label htmlFor={id} className="block text-sm font-medium text-slate-700 mb-1">
                    {label}
                </label>
            )}
            <input
                id={id}
                type={type}
                value={value}
                onChange={onChange}
                placeholder={placeholder}
                required={required}
                className="w-full px-4 py-2 rounded-xl border border-surface-200 focus:outline-none focus:ring-2 focus:ring-primary-500/20 focus:border-primary-500 transition-all bg-white text-slate-900 placeholder-slate-400"
            />
        </div>
    );
};

export default Input;
