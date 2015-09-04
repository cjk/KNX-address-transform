KnxAddressImport
================

## A small tool to help you bringing over your KNX-group-addresses into your favorite home-automation project

First, export your group-addresses using ETS into a CSV-file, then feed it to this transformer which converts it into a simple JSON-like list:

```
{
  "name": "Central lights off",
  "id": "0/0/1"
}{
  "name": "Livingroom lights",
  "id": "1/1/0"
}{
  "name": "Basement South-Window sensors",
  "id": "1/1/1"
}
{ … }
```

## Usage

This program requires Elixir / Erlang. Once installed, you can compile and run it via:

`mix compile`

`mix run -e 'IO.inspect(KnxAddressImport.start())'`

Don’t forget to also run `mix deps.get` once to install needed dependencies (CSV-/JSON-parser).
