defmodule SpotifyApiWeb.OpenApiController do
  use SpotifyApiWeb, :controller

  def spec(conn, _params) do
    json(conn, SpotifyApiWeb.ApiSpec.spec())
  end
end
