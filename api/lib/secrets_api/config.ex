defmodule SecretsApi.Config do
  @spec config!(atom(), atom()) :: any() | no_return
  def config!(mod, key) do
    Application.get_env(:secrets_api, mod)
    |> parse_app_env!(key)
  end

  defp parse_config_value({:system, var}), do: System.get_env(var)
  defp parse_config_value(value), do: value

  defp parse_app_env!(nil, key), do: raise("#{key} not set!")

  defp parse_app_env!(args, key) do
    case Keyword.get(args, key) do
      nil -> raise "#{key} not set!"
      {:system, var} -> System.get_env(var)
      value -> value
    end
  end
end
