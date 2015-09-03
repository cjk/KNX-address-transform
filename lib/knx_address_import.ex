defmodule KnxAddressImport do
  File.stream!("addr.csv") |>
    CSV.decode(separator: ?\t) |>
    Enum.map fn row -> IO.puts row
  end
end
