defmodule Secrets.Features.HomePageTest do
  use Secrets.FeatureCase, async: true

  import Wallaby.Query

  test "home page displays hello world", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("h1", text: "Go ahead, share your secrets :)"))
  end
end
