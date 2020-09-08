defmodule AmarisPhoenixLabWeb.Router do
  use AmarisPhoenixLabWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AmarisPhoenixLabWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AmarisPhoenixLabWeb do
    pipe_through :browser

    live "/", PageLive, :index

    # Accounts.User routes
    live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Index, :new
    live "/users/:id/edit", UserLive.Index, :edit
    live "/users/:id", UserLive.Show, :show
    live "/users/:id/show/edit", UserLive.Show, :edit

    # CMS.Project routes
    live "/projects", ProjectLive.Index, :index
    live "/projects/new", ProjectLive.Index, :new
    live "/projects/:id/edit", ProjectLive.Index, :edit
    live "/projects/:id", ProjectLive.Show, :show
    live "/projects/:id/show/edit", ProjectLive.Show, :edit

    # CMS.Category routes
    live "/categories", CategoryLive.Index, :index
    live "/categories/new", CategoryLive.Index, :new
    live "/categories/:id/edit", CategoryLive.Index, :edit
    live "/categories/:id", CategoryLive.Show, :show
    live "/categories/:id/show/edit", CategoryLive.Show, :edit

    # CMS.MaterialType routes
    live "/material_types", MaterialTypeLive.Index, :index
    live "/material_types/new", MaterialTypeLive.Index, :new
    live "/material_types/:id/edit", MaterialTypeLive.Index, :edit
    live "/material_types/:id", MaterialTypeLive.Show, :show
    live "/material_types/:id/show/edit", MaterialTypeLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", AmarisPhoenixLabWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AmarisPhoenixLabWeb.Telemetry
    end
  end
end
