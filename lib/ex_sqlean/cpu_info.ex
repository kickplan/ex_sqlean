defmodule ExSqlean.CpuInfo do
  @doc """
  Responds with os type / cpu type tuple.

  Example:
      iex_ > ExSqlean.CpuInfo.fullinfo()
      {:macos, "x86_64"}
  """
  @spec platform :: {atom(), binary()}
  def platform do
    case :persistent_term.get(__MODULE__, nil) do
      nil ->
        {os_type(), cpu_type()}
        |> tap(fn info -> :persistent_term.put(__MODULE__, info) end)

      fullinfo ->
        fullinfo
    end
  end

  defp cpu_type do
    :erlang.system_info(:system_architecture)
    |> List.to_string()
    |> String.split("-")
    |> List.first()
  end

  defp os_type do
    case :os.type() do
      {:unix, :linux} -> :linux
      {:unix, :darwin} -> :macos
      {:unix, :freebsd} -> :freebsd
      {:win32, _} -> :windows
      _ -> :unknown
    end
  end
end
