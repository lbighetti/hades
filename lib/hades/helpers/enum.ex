defmodule Hades.Helpers.Enum do
  @moduledoc """

  In your schema module, you can define your enum by importing this helper:

  defmodule User do
    @moduledoc false

    import Hades.Helpers.Enum

    enum "status" do
      %{
        active: 1,
        inactive: 2
      }
    end
  end

  You can then use your status enum like,

  my_user = User |> Repo.get(1)
  if my_user.status == User.status[:active] do
    # do stuff
  end

  """
  defmacro enum(name, [do: block]) do
    enum_values = case block do
      {_, _, values} when is_list(values) ->
        values
      _ ->
        quote do
          {:error, "please provide Map with %{key: value} for enum"}
        end
    end

    quote do
      def unquote(:"#{name}")() do
        unquote(enum_values)
      end
    end
  end
end