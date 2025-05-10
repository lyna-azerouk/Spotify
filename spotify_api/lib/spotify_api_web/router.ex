defmodule SpotifyApiWeb.Router do
  use SpotifyApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SpotifyApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpotifyApiWeb do
    pipe_through :api

    get "/artists/:name/albums", AlbumController, :index
  end

  scope "/" do
    pipe_through :api

    get "/api/openapi", SpotifyApiWeb.OpenApiController, :spec

    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI,
      path: "",
      urls: [%{url: "/api/openapi", name: "Mon API"}]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpotifyApiWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:spotify_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SpotifyApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
