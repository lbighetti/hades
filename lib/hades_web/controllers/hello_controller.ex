defmodule HadesWeb.HelloController do
  use HadesWeb, :controller

  def hello(conn, _) do
    text conn, "Hello World!"
  end
end