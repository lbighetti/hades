defmodule HadesWeb.Router do
  use HadesWeb, :router
  alias HelloController

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authorized do
    plug HadesWeb.AuthPipeline
  end

  scope "/api", HadesWeb do
    pipe_through :api

    get  "/hello",        HelloController, :hello
    post "/auth/sign_up", AuthController,  :sign_up
    post "/auth/sign_in", AuthController,  :sign_in
  end

  scope "/api", HadesWeb do
    pipe_through [:api, :authorized]

    get       "/users/:id",     UserController,            :get_user
    put       "/users",         UserController,            :update_user
    put       "/user/password", UserController,            :update_user_password
    put       "/user/status",   UserController,            :update_user_status
    delete    "/auth/sign_out", AuthController,            :sign_out
    resources "/mentors",       MentorController,   only: [:index, :create, :show, :update]
    resources "/mentorees",     MentoreeController, only: [:index, :create, :show, :update]
  end
end
