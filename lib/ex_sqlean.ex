defmodule ExSqlean do
  @moduledoc """
  Documentation for `ExSqlean`.
  """

  alias ExSqlean.Extensions

  @extensions Extensions.all()
  def extensions, do: @extensions

  def ext_path(extension) when extension in @extensions do
    Extensions.path() |> Path.join(extension)
  end

  def ext_path(extension) do
    raise(
      "Extension '#{extension}' not available! Please pick one from #{inspect(@extensions)}."
    )
  end
end
