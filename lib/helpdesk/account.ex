defmodule Helpdesk.Account do
  use Ash.Domain

  resources do
    resource Helpdesk.Account.UserSession
  end
end
