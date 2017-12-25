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
    get "/users/:id", UserController, :get_user
    resources "/mentors", MentorController, only: [:index, :create, :show, :update]
  end
end
