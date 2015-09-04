defmodule KnxAddressImport do
  ## Run with KnxAddressImport.start()

  import Enum
  alias Poison, as: JSON

  defmodule Address do
    @derive [Poison.Encoder]
    defstruct [:id, :name]
    @type t :: %Address{id: String.t, name: String.t}
  end

  defp read_csv(filename) do
    File.stream!(filename, [{:encoding, :utf8}]) |>
      CSV.decode(separator: ?\t) |>
      filter(
        # Use only complete group-addresses
        fn row -> !any?(row, &(&1 == " ")) end
      )
  end

  defp import() do
    read_csv("addr.csv") |>
    ## Map to struct
    map(fn(row) -> %Address{id: join(tl(row), "/"), name: hd(row)} end)
    ## Debug output
    # >| map(&(IO.inspect(&1)))
  end

  defp export(addrlist) do
    File.write("addr.json", map(addrlist, fn addr -> JSON.encode!(addr, pretty: true) end), [:delayed_write])
  end

  def start(), do: import() |> export()
end
