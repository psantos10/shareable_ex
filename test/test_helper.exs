ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ShareableEx.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ShareableEx.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ShareableEx.Repo)

