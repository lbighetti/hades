defmodule HadesWeb.HelloController do
  use HadesWeb, :controller

  def hello(conn, _) do
    text conn, "Hi There! Welcome to Hades!"
  end
end