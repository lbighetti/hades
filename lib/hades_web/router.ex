defmodule HadesWeb.Router do
  use HadesWeb, :router
  alias HelloController

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HadesWeb do
    pipe_through :api

    get "/hello", HelloController, :hello
    post "/auth/signup", AuthController, :signup
  end
end
