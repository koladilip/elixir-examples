defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    spawn(fn -> manage_account(0) end)
  end

  def manage_account(balance) do
    receive do
      {:close, caller} ->
        send caller, :closed
      {:balance, caller} ->
        send caller, balance
        manage_account(balance)
      {:update, caller, amount} ->
        send caller, balance + amount
        manage_account(balance + amount)
    end
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    if Process.alive?(account) do
      send(account, {:close, self()})
      receive do
        :closed -> :closed
      end
    end
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    unless Process.alive?(account) do
      {:error, :account_closed}
    else
      send(account, {:balance, self()})
      receive do
        balance -> balance
      end
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    unless Process.alive?(account) do
      {:error, :account_closed}
    else
      send(account, {:update, self(), amount})
      receive do
        balance -> balance
      end
    end
  end
end
