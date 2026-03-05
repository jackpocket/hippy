defmodule Hippy.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch,
       name: Hippy.Finch,
       pools: %{
         default: [
           conn_opts: [
             transport_opts: [
               verify: :verify_none
             ]
           ]
         ]
       }}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
