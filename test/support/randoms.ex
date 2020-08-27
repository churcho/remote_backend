defmodule RemoteBackend.Support.Randoms do
  @moduledoc """
  Generates randomized fields.
  """
  # credo:disable-for-this-file

  require Logger

  defdelegate pick(enum), to: Faker.Util
  defdelegate digit(), to: Faker.Util

  def random(:integer), do: Faker.random_between(-1_000_000, 1_000_000)
  def random(:points), do: pick(0..100)
  def random(_), do: nil

  # Default Cases
  def random(field, type) do
    case {random(field), random(type)} do
      {nil, nil} ->
        Logger.warn("""
        ------------------------------------------------
        `SFX.Randoms.random/2` was unable to generate a case for:
          iex> Randoms.random(#{inspect(field)}, #{inspect(type)})
        ------------------------------------------------
        """)

        nil

      {random_field, random_type} ->
        random_field || random_type
    end
  end
end
