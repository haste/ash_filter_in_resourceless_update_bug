defmodule Helpdesk.Account.UserSession do
  use Ash.Resource, domain: Helpdesk.Account, data_layer: AshPostgres.DataLayer

  postgres do
    table "user_sessions"
    repo Helpdesk.Repo
  end

  code_interface do
    define :read, action: :read, get_by: [:session_uid], get?: true

    define :create, action: :create

    define :logout,
      action: :logout,
      require_reference?: false
  end

  actions do
    defaults [:read]

    create :create do
      accept [:session_uid, :user_id]
      upsert? true
      upsert_identity :primary
    end

    update :logout do
      change filter expr(session_uid == ^actor(:session_uid))
      accept []
      change set_attribute(:user_id, nil)
    end
  end

  attributes do
    uuid_primary_key :session_uid, writable?: true
    attribute :user_id, :integer
  end

  identities do
    identity :primary, :session_uid
  end
end
