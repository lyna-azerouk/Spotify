defmodule SpotifyApiWeb.ApiSpec do
  alias OpenApiSpex.{
    Info,
    OpenApi,
    Server,
    Paths
  }

  alias SpotifyApiWeb.Schemas

  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      openapi: "3.1.0",
      info: %Info{
        title: "Phoenix App",
        version: "1.0"
      },
      servers: [
        %Server{url: "/"}
      ],
      paths: Paths.from_router(SpotifyApiWeb.Router)
    }
  end
end
