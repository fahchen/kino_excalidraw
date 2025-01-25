import React, { useId } from "react";

export function InputField(
  {
    label,
    description,
    defaultValue,
    onChange,
    ...props
  },
) {
  const id = useId();

  return (
    <div className="col-span-4">
      <label
        htmlFor={id}
        className="block text-sm/6 font-medium text-gray-900"
      >
        {label}
      </label>
      <div className="mt-2">
        <input
          id={id}
          // use important to overwrite excalidraw's style
          className="block w-full !rounded-md !bg-white !px-3 !py-1.5 !text-base !text-gray-900 !outline !outline-1 !-outline-offset-1 !outline-gray-300 !placeholder:text-gray-400 focus:outline !focus:outline-2 !focus:-outline-offset-2 !focus:outline-indigo-600"
          defaultValue={defaultValue}
          onChange={onChange}
          {...props}
        />
      </div>
      {description && (
        <p className="text-gray-600 text-xs">
          {description}
        </p>
      )}
    </div>
  );
}

export function OptionField({ label, defaultChecked, onChange, ...props }) {
  const id = useId();

  return (
    <div className="flex gap-3">
      <div className="flex h-6 shrink-0 items-center">
        <div className="group grid size-4 grid-cols-1">
          <input
            id={id}
            type="checkbox"
            className="col-start-1 row-start-1 appearance-none rounded border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
            defaultChecked={defaultChecked}
            onChange={onChange}
            {...props}
          />
          <svg
            fill="none"
            viewBox="0 0 14 14"
            className="pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-[:disabled]:stroke-gray-950/25"
          >
            <path
              d="M3 8L6 11L11 3.5"
              strokeWidth={2}
              strokeLinecap="round"
              strokeLinejoin="round"
              className="opacity-0 group-has-[:checked]:opacity-100"
            />
            <path
              d="M3 7H11"
              strokeWidth={2}
              strokeLinecap="round"
              strokeLinejoin="round"
              className="opacity-0 group-has-[:indeterminate]:opacity-100"
            />
          </svg>
        </div>
      </div>
      <div className="text-sm/6">
        <label htmlFor={id} className="font-medium text-gray-900">
          {label}
        </label>
      </div>
    </div>
  );
}
