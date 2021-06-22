defmodule SecretsApi.AnalyticsTest do
  use SecretsApi.DataCase

  alias SecretsApi.Analytics

  describe "analytics" do
    test "get_secrets_counter/0 is 0 by default" do
      assert Analytics.get_secrets_counter() == 0
    end

    test "set_secrets_counter/0 sets the secrets counter to a value" do
      Analytics.set_secrets_counter(4)

      assert Analytics.get_secrets_counter() == 4
    end

    test "increment_secrets_counter/0 increments the secrets counter" do
      prev_counter = Analytics.get_secrets_counter()

      Analytics.increment_secrets_counter()

      assert Analytics.get_secrets_counter() == prev_counter + 1
    end
  end
end
