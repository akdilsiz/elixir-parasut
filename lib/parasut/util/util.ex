defmodule Parasut.Util do

  @doc """
  Create an HMAC-SHA256 for `key` and `message`.
  """
  def hmac_sha256(key, message) do
    :crypto.hmac(:sha256, key, message)
  end

  @doc """
  Create an HMAC-SHA256 hexdigest for `key` and `message`.
  """
  def hmac_sha256_hexdigest(key, message) do
    hmac_sha256(key, message) |> Base.encode16(case: :lower)
  end

  @doc """
  Create a SHA256 hexdigest for `value`.
  """
  def sha256_hexdigest(value) do
    :crypto.hash(:sha256, value) |> Base.encode16(case: :lower)
  end

  # ref: https://stackoverflow.com/questions/32001606/how-to-generate-a-random-url-safe-string-with-elixir
  def random_string(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64
    |> binary_part(0, length)
  end

  def random_integer(max \\ 999_999_999) do
    :rand.uniform(max)
    |> Integer.to_string
    |> String.pad_trailing(Enum.count(Integer.digits(max)), "0")
    |> String.to_integer
  end	
end