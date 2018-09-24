defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd
  end

  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end

  def pick_color(image) do
    %Identicon.Image{hex: [r ,g, b | _tail]} = image
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: [r ,g, b | _tail]} = image) do
    grid = hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row / 1)
      |> List.flatten
      |> Enum.with_index
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def filter_odd(%Identicon.Image{grid: grid} = image) do
    Enum.filter grid, fn({code, _index}) -> 
      rem(code, 2) == 0
    end
  end

end
