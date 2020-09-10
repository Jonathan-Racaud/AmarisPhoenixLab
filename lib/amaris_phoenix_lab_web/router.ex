defmodule AmarisPhoenixLabWeb.Router do
  use AmarisPhoenixLabWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AmarisPhoenixLabWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :admin do
    plug AmarisPhoenixLabWeb.EnsureRolePlug, :admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", AmarisPhoenixLabWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/", AmarisPhoenixLabWeb do
    pipe_through [:browser, :authenticated]

    # CMS.Category route
    live "/categories", CategoryLive.Index, :index

    # CMS.Project routes
    live "/projects", ProjectLive.Index, :index

    # Users.User routes
    live "/users", UserLive.Index, :index
  end

  scope "/", AmarisPhoenixLabWeb do
    pipe_through [:browser, :authenticated, :admin]

    # CMS.Category routes
    live "/categories/new", CategoryLive.Index, :new
    live "/categories/:id/edit", CategoryLive.Index, :edit
    live "/categories/:id/show/edit", CategoryLive.Show, :edit

    # CMS.MaterialType routes
    live "/material_types", MaterialTypeLive.Index, :index
    live "/material_types/new", MaterialTypeLive.Index, :new
    live "/material_types/:id/edit", MaterialTypeLive.Index, :edit
    live "/material_types/:id", MaterialTypeLive.Show, :show
    live "/material_types/:id/show/edit", MaterialTypeLive.Show, :edit

    # CMS.Project routes
    live "/projects/new", ProjectLive.Index, :new # Needs to be put befor /projects/:id otherwise "new" is sent as the :id
    live "/projects/:id/edit", ProjectLive.Index, :edit
    live "/projects/:id/show/edit", ProjectLive.Show, :edit

    # Users.User routes
    live "/users/new", UserLive.Index, :new
    live "/users/:id/edit", UserLive.Index, :edit
    live "/users/:id/show/edit", UserLive.Show, :edit

    # # CMS.Material routes
    # live "/materials", MaterialLive.Index, :index
    # live "/materials/new", MaterialLive.Index, :new
    # live "/materials/:id/edit", MaterialLive.Index, :edit
    # live "/materials/:id", MaterialLive.Show, :show
    # live "/materials/:id/show/edit", MaterialLive.Show, :edit
  end

  scope "/", AmarisPhoenixLabWeb do
    pipe_through [:browser, :authenticated]

    live "/users/:id", UserLive.Show, :show
    live "/projects/:id", ProjectLive.Show, :show
    live "/categories/:id", CategoryLive.Show, :show
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
