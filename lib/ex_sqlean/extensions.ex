defmodule ExSqlean.Extensions do
  alias ExSqlean.CpuInfo

  def all do
    path()
    |> Path.join("*")
    |> Path.wildcard()
    |> Stream.map(&Path.basename/1)
    |> Stream.map(&Path.rootname/1)
    |> Enum.to_list()
  end

  def dirname do
    case CpuInfo.platform() do
      {:linux, "x86_64"} -> "linux-x86"
      {:linux, _} -> "linux-arm64"
      {:macos, "x86_64"} -> "macos-x86"
      {:macos, _} -> "macos-arm64"
      {:windows, "win32"} -> "win-x86"
      {:windows, _} -> "win-x64"
    end
  end

  def path do
    :code.priv_dir(:ex_sqlean)
    |> Path.join(dirname())
  end
end
