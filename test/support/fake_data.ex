defmodule Hades.FakeData do
  require ExUnitProperties

  def email do
    domains = ~w(gmail.com hotmail.com yahoo.com)

    email_generator =
      ExUnitProperties.gen all name <- StreamData.string(:alphanumeric),
                               name != "",
                               domain <- StreamData.member_of(domains) do
        name <> "@" <> domain
      end

    Enum.take(StreamData.resize(email_generator, 20), 1) |> List.last
  end

  def boolean do
    Enum.take(StreamData.boolean, 1) |> List.last
  end

  def term(length) do
    Enum.take(StreamData.string(:alphanumeric), length) |> List.last
  end
end