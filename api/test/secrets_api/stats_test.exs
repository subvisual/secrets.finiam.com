defmodule SecretsApi.StatsTest do
  use SecretsApi.DataCase

  alias SecretsApi.Stats

  describe "stats" do
    test "get_secrets_counter/0 is 0 by default" do
      assert Stats.get_secrets_counter() == 0
    end

    test "set_secrets_counter/0 sets the secrets counter to a value" do
      Stats.set_secrets_counter(4)

      assert Stats.get_secrets_counter() == 4
    end

    test "increment_secrets_counter/0 increments the secrets counter" do
      prev_counter = Stats.get_secrets_counter()

      Stats.increment_secrets_counter()

      assert Stats.get_secrets_counter() == prev_counter + 1
    end
  end
end
