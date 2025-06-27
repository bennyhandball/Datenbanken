import React, { useState } from 'react';

export default function ChatInputBar() {
  const [open, setOpen] = useState(false);
  const toggle = () => setOpen(!open);

  return (
    <div className="flex items-center bg-gray-700 text-gray-200 rounded-lg p-2 space-x-2 w-full">
      {/* Tools dropdown */}
      <div className="relative">
        <button
          onClick={toggle}
          className="flex items-center px-3 py-1 bg-gray-600 rounded-md hover:bg-gray-500 focus:outline-none"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-4 w-4 mr-1"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
          </svg>
          <span className="text-sm">Tools</span>
        </button>
        {open && (
          <div className="absolute left-0 mt-1 w-32 bg-gray-600 rounded-md shadow-lg z-10">
            <ul className="text-sm py-1">
              <li className="px-3 py-1 hover:bg-gray-500 cursor-pointer">Option 1</li>
              <li className="px-3 py-1 hover:bg-gray-500 cursor-pointer">Option 2</li>
            </ul>
          </div>
        )}
      </div>

      {/* Input field */}
      <input
        type="text"
        placeholder="Ask anything"
        className="flex-1 bg-gray-600 placeholder-gray-400 text-white px-3 py-2 rounded-md focus:outline-none"
      />

      {/* Voice buttons */}
      <button className="p-2 hover:bg-gray-600 rounded-md">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          className="h-5 w-5"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 1v22M5 6h14M5 18h14" />
        </svg>
      </button>
      <button className="p-2 hover:bg-gray-600 rounded-md">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          className="h-5 w-5"
          viewBox="0 0 20 20"
          fill="currentColor"
        >
          <path d="M2 10h2v2H2v-2zm4-4h2v6H6V6zm4-2h2v10h-2V4zm4 4h2v2h-2V8zm4-2h2v6h-2V6z" />
        </svg>
      </button>
    </div>
  );
}
