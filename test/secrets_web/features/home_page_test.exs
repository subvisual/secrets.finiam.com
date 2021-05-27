defmodule Secrets.Features.HomePageTest do
  use Secrets.FeatureCase, async: true

  import Wallaby.Query

  test "home page displays hello world", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("p", text: "Hello World!"))
    |> assert_has(css("p", text: "API Result: example"))
  end
end
