defmodule FleatureWeb.Router do
  use FleatureWeb, :router

  import FleatureWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FleatureWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug FleatureWeb.Plugs.DefaultPageTitle
  end

  scope "/", FleatureWeb do
    pipe_through [:browser]

    live "/", HomeLive, :index
    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end

  scope "/", FleatureWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", FleatureWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :default do
      live "/organizations/create", OrganizationsLive, :create
      live "/organizations/:organization_id", OrganizationsLive, :view
      live "/organizations/:organization_id/edit", OrganizationsLive, :edit
      live "/organizations/:organization_id/projects/create", ProjectsLive, :create
      live "/projects/:project_id", ProjectsLive, :view
      live "/projects/:project_id/edit", ProjectsLive, :edit

      live "/projects/:project_id/environments/create",
           EnvironmentsLive,
           :create

      live "/environments/:environment_id",
           EnvironmentsLive,
           :view

      live "/environments/:environment_id/feature_flags/create",
           FeatureFlagsLive,
           :create
    end

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: FleatureWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
