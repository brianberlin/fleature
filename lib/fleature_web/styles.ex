defmodule FleatureWeb.Styles do
  @styles [
    form: [
      container: [
        top: "min-h-full flex flex-col justify-center py-12 sm:px-6 lg:px-8",
        header: "sm:mx-auto sm:w-full sm:max-w-md",
        section: [
          outer: "mt-8 sm:mx-auto sm:w-full sm:max-w-md",
          inner: "bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10",
        ]
      ]
    ],
    text: [
      h2: "mt-6 text-center text-3xl font-extrabold text-gray-900",
      small_gray: "mt-2 text-center text-sm text-gray-600",
    ]
  ]

  def get(selector), do: get_in(@styles, selector)
end
