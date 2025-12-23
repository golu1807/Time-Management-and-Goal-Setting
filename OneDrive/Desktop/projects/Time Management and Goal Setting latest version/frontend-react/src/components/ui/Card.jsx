import React from 'react';

const Card = ({ children, className = '', hover = false }) => {
    return (
        <div
            className={`
        bg-white rounded-2xl p-6 shadow-soft border border-surface-100
        ${hover ? 'transition-all duration-300 hover:-translate-y-1 hover:shadow-lg' : ''}
        ${className}
      `}
        >
            {children}
        </div>
    );
};

export default Card;
