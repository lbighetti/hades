defmodule HadesWeb.Router do
  use HadesWeb, :router
  alias HelloController

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :unauthorized do
    plug :fetch_session
  end

  pipeline :authorized do
    plug :fetch_session
    plug Guardian.Plug.Pipeline, module: Hades.Guardian,
      error_handler: Hades.AuthErrorHandler
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/api", HadesWeb do
    pipe_through [:api, :unauthorized]

    get "/hello", HelloController, :hello
    post "/auth/signup", AuthController, :signup
  end

  scope "/api", HadesWeb do
    pipe_through [:api, :authorized]

    get "/users/:id", UserController, :get_user
    resources "/mentors", MentorController, only: [:index, :create, :show, :update]
  end
end
