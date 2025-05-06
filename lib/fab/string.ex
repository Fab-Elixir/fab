defmodule Fab.String do
  @moduledoc """
  Functions for generating random strings.
  """

  import Fab.Randomizer

  @type case_t ::
          {:case, :lower | :mixed | :upper}

  @type exclude_t ::
          {:exclude, [String.t()]}

  @type max_t ::
          {:max, pos_integer}

  @type min_t ::
          {:min, pos_integer}

  @alpha_lower [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ]

  @alpha_upper [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ]

  @numeric [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ]

  @symbol [
    "!",
    "\"",
    "#",
    "$",
    "%",
    "&",
    "'",
    "(",
    ")",
    "*",
    "+",
    ",",
    "-",
    ".",
    "/",
    ":",
    ";",
    "<",
    "=",
    ">",
    "?",
    "@",
    "[",
    "\\",
    "]",
    "^",
    "_",
    "`",
    "{",
    "|",
    "}",
    "~"
  ]

  @doc """
  Returns a random string consisting of letters from the English alphabet.

  ## Options

  - `:case` - Case of the characters. Can be `:lower`, `:mixed` or `:upper`.
    Defaults to `:mixed`.
  - `:exclude` - List of characters to exclude from the result
  - `:min` - Minimum number of characters to generate
  - `:max` - Maximum number of characters to generate

  ## Examples

      iex> Fab.String.alpha()
      "b"

      iex> Fab.String.alpha(5)
      "beTko"

      iex> Fab.String.alpha(case: :lower)
      "b"

      iex> Fab.String.alpha(case: :upper)
      "B"

      iex> Fab.String.alpha(exclude: ["j"])
      "h"

      iex> Fab.String.alpha(min: 5, max: 10)
      "beTkoB"
  """
  @spec alpha([case_t | exclude_t | max_t | min_t]) :: String.t()
  def alpha(opts \\ []) do
    opts
    |> casing()
    |> exclude(opts)
    |> from_characters(opts)
  end

  @doc """
  Returns a random string consisting of numbers and letters from the English
  alphabet.

  ## Options

  - `:case` - Case of the characters. Can be `:lower`, `:mixed` or `:upper`.
    Defaults to `:mixed`.
  - `:exclude` - List of characters to exclude from the result
  - `:min` - Minimum number of characters to generate
  - `:max` - Maximum number of characters to generate

  ## Examples

      iex> Fab.String.alphanumeric()
      "c"

      iex> Fab.String.alphanumeric(5)
      "cuCMf"

      iex> Fab.String.alphanumeric(case: :lower)
      "6"

      iex> Fab.String.alphanumeric(case: :upper)
      "6"

      iex> Fab.String.alphanumeric(exclude: ["q"])
      "Z"

      iex> Fab.String.alphanumeric(min: 5, max: 10)
      "cuCMf7jVfe"
  """
  @spec alphanumeric([case_t | exclude_t | max_t | min_t]) :: String.t()
  def alphanumeric(opts \\ []) do
    characters = casing(opts)
    characters = characters ++ @numeric
    characters = exclude(characters, opts)

    from_characters(characters, opts)
  end

  @doc """
  Returns a random string consisting of symbols, numbers and letters from the
  English alphabet.

  ## Examples

      iex> Fab.String.any()
      "`"

      iex> Fab.String.any(5)
      "`>9k@"

      iex> Fab.String.any(case: :lower)
      "9"

      iex> Fab.String.any(case: :upper)
      "9"

      iex> Fab.String.any(exclude: ["&"])
      "u"

      iex> Fab.String.any(min: 5, max: 10)
      "`>9k@*5'b"
  """
  @spec any([case_t | exclude_t | max_t | min_t]) :: String.t()
  def any(opts \\ []) do
    characters = casing(opts)
    characters = characters ++ @numeric
    characters = characters ++ @symbol
    characters = exclude(characters, opts)

    from_characters(characters, opts)
  end

  @spec casing(keyword) :: [String.t()]
  defp casing(opts) when is_list(opts) do
    case Keyword.get(opts, :case, :mixed) do
      :lower ->
        @alpha_lower

      :mixed ->
        @alpha_lower ++ @alpha_upper

      :upper ->
        @alpha_upper
    end
  end

  defp casing(_opts) do
    casing([])
  end

  @doc """
  Returns a random string from the given characters.

  ## Options

  - `:min` - Minimum number of characters to generate
  - `:max` - Maximum number of characters to generate

  ## Examples

      iex> Fab.String.from_characters(["a", "b", "c"])
      "a"

      iex> Fab.String.from_characters("abc")
      "a"

      iex> Fab.String.from_characters("abc", 5)
      "abbba"

      iex> Fab.String.from_characters("abc", min: 5, max: 10)
      "abbbaca"
  """
  @spec from_characters(String.t() | [String.t()], [max_t | min_t]) :: String.t()
  def from_characters(characters, opts \\ [])

  def from_characters(characters, opts) when is_binary(characters) do
    characters
    |> String.split("", trim: true)
    |> from_characters(opts)
  end

  def from_characters(characters, n) when is_integer(n) do
    from_characters(characters, min: n, max: n)
  end

  def from_characters(characters, opts) do
    min = Keyword.get(opts, :min, 1)
    max = Keyword.get(opts, :max, 1)

    range = 1..random(min..max)

    Enum.reduce(range, "", fn _, acc ->
      acc <> random(characters)
    end)
  end

  @doc """
  Returns a random string consisting of numbers.

  ## Options

  - `:exclude` - List of characters to exclude from the result
  - `:min` - Minimum number of characters to generate
  - `:max` - Maximum number of characters to generate

  ## Examples

      iex> Fab.String.numeric()
      "4"

      iex> Fab.String.numeric(5)
      "40427"

      iex> Fab.String.numeric(exclude: ["1"])
      "6"

      iex> Fab.String.numeric(min: 5, max: 10)
      "4042773592"
  """
  @spec numeric([exclude_t | max_t | min_t]) :: String.t()
  def numeric(opts \\ []) do
    @numeric
    |> exclude(opts)
    |> from_characters(opts)
  end

  @doc """
  Returns a random string consisting of ASCII symbol characters.

  ## Symbols

  ```
  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \\ ] ^ _ ` { | } ~
  ```

  ## Options

  - `:exclude` - List of characters to exclude from the result
  - `:min` - Minimum number of characters to generate
  - `:max` - Maximum number of characters to generate

  ## Examples

      iex> Fab.String.symbol()
      "}"

      iex> Fab.String.symbol(5)
      "}&$^!"

      iex> Fab.String.symbol(exclude: ["!"])
      "("

      iex> Fab.String.symbol(min: 5, max: 10)
      "}&$^!]?)`"
  """
  @spec symbol([exclude_t | max_t | min_t]) :: String.t()
  def symbol(opts \\ []) do
    @symbol
    |> exclude(opts)
    |> from_characters(opts)
  end

  @spec exclude([String.t()], keyword) :: [String.t()]
  defp exclude(characters, opts) when is_list(opts) do
    Enum.reduce(characters, [], fn character, acc ->
      exclude = Keyword.get(opts, :exclude, [])

      if character in exclude do
        acc
      else
        acc ++ [character]
      end
    end)
  end

  defp exclude(characters, _opts) do
    exclude(characters, [])
  end
end
