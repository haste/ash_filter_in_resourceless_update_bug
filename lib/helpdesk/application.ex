defmodule Helpdesk.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [Helpdesk.Repo]

    opts = [strategy: :one_for_one, name: Helpdesk.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
