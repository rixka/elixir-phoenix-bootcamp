defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffling randomises a given `deck` of cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Devides a deck into a hand and the remainder of a deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves the the deck locally.
    The `filename` argument indicates the local
    file to save to..
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary deck
    File.write(filename, binary)
  end

  @doc """
    Reads a local file and returns the deck.
    The `filename` argument indactes the local
    file to read.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "Error: That file does not exist"
    end
  end

  @doc """
    Defines a deck, shuffles the deck, and deals a hand.
    The `hand_size` argument indicates how many cards should
    be in the hand.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle(hand_size)
    |> Cards.deal(hand_size)
  end
end
