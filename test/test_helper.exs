ExUnit.start()
Application.put_env(:wallaby, :base_url, SecretsWeb.Endpoint.url())
{:ok, _apps} = Application.ensure_all_started(:wallaby)
