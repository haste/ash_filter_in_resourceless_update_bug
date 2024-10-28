defmodule Helpdesk.Account.UserSessionTest do
  use Helpdesk.DataCase, async: true

  alias Helpdesk.Account.UserSession

  test "logout" do
    attrs = %{
      user_id: 1
    }

    {:ok, user_session} = UserSession.create(attrs)

    %Ash.BulkResult{
      status: :success,
      errors: nil,
      records: nil,
      notifications: [],
      error_count: 0
    } =
      UserSession.logout(actor: %{session_uid: user_session.session_uid})

    {:ok, logged_out_session} = UserSession.read(user_session.session_uid)
    assert is_nil(logged_out_session.user_id)
  end
end
