defmodule RemoteBackend.Support.CustomAsserts do
  @moduledoc """
  Custom assertions for ex_unit
  """
  @doc """
  Asserts that the given changeset is invalid, and that when the
  assertion_expression is applied to the error_message it results in a truthy
  value.
  """
  defmacro assert_invalid(changeset, field, assertion_expression) when is_atom(field) do
    expr = Macro.to_string(assertion_expression)

    quote do
      c = unquote(changeset)

      with {:valid, false} <- {:valid, Map.get(c, :valid?)},
           {:field, true} <- {:field, Map.keys(c.data) |> Enum.member?(unquote(field))},
           {:message, {message, _opts}} <- {:message, Keyword.get(c.errors, unquote(field))} do
        var!(error_message) = message

        if unquote(assertion_expression) do
          assert true
        else
          flunk("""
          Expression did not match error message

          #{IO.ANSI.cyan()}error_message:#{IO.ANSI.reset()} #{inspect(message)}
          #{IO.ANSI.cyan()}expression:#{IO.ANSI.reset()} #{unquote(expr)}
          """)
        end
      else
        {:valid, nil} ->
          raise "assert_invalid/3 requires a changeset for the first argument"

        {:valid, true} ->
          flunk(
            "#{inspect(c.data.__struct__)} is valid, expected at least one field to be invalid"
          )

        {:field, _} ->
          raise "field :#{unquote(field)} not found in #{inspect(c.data.__struct__)}"

        {:message, _} ->
          flunk(":#{unquote(field)} field is valid, expected it to be invalid")
      end
    end
  end
end
