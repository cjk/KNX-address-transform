defmodule KnxAddressImport do
  # run with KnxAddressImport.read_csv("addr.csv")

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
        fn row -> !any?(row, &(&1 == " ")) end
      )
  end

  defp write_json(addrlist) do
    File.write("addr.json", map(addrlist, fn addr -> JSON.encode!(addr, pretty: true) end), [:delayed_write])
  end

  def import() do
    read_csv("addr.csv") |>
    map(fn(row) -> %Address{id: join(tl(row), "/"), name: hd(row)} end) |>
    map(&(IO.inspect(&1))) |>
    write_json
  end
end
