defmodule NewTest do
  use ExUnit.Case
  doctest New

  test "create_deck makes 40 cards" do
  	deck_length = length(New.create_deck)
  	assert deck_length == 40
  end
end
