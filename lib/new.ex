defmodule New do
  @moduledoc """
    Provides cards methods
  """

  @doc """
    Returns a list of strings of playing cards
  """
  def create_deck do 
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Randomly shuffle all elements of `Enum` struct
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determine if card exist in deck

    ## Examples

      iex> deck = New.create_deck
      iex> New.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides cards 

    ## Examples

      iex> deck = New.create_deck
      iex> {hand, _deck} = New.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, size) do
    Enum.split(deck, size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary } -> :erlang.binary_to_term binary
      {:error, _reason } -> "That file does not exist"
    end
  end

  def create_hand(size) do
    New.create_deck
    |> New.shuffle
    |> New.deal(size)
  end
end







