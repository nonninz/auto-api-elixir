defmodule AutoApi.WindowsState do
  @moduledoc """
  Keeps Windows state
  """

  alias AutoApi.PropertyComponent

  @doc """
  Windows state
  """
  defstruct open_percentages: [],
            positions: [],
            timestamp: nil

  use AutoApi.State, spec_file: "specs/windows.json"

  @type location :: :front_left | :front_right | :rear_left | :rear_right | :hatch
  @type position :: :close | :open | :intermediate
  @type positions :: %PropertyComponent{
          data: %{location: location, window_position: position}
        }
  @type open_percentages :: %PropertyComponent{
          data: %{location: location, open_percentage: float}
        }

  @type t :: %__MODULE__{
          open_percentages: list(open_percentages),
          positions: list(positions),
          timestamp: DateTime.t() | nil
        }

  @doc """
  Build state based on binary value

    iex> bin = <<2, 0, 12, 1, 0, 9, 4, 63, 199, 10, 61, 112, 163, 215, 10>>
    iex> AutoApi.WindowsState.from_bin(bin)
    %AutoApi.WindowsState{open_percentages: [%AutoApi.PropertyComponent{data: %{location: :hatch, open_percentage: 0.18}}]}
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @doc """
  Parse state to bin

    iex> state = %AutoApi.WindowsState{open_percentages: [%AutoApi.PropertyComponent{data: %{location: :hatch, open_percentage: 0.18}}]}
    iex> AutoApi.WindowsState.to_bin(state)
    <<2, 0, 12, 1, 0, 9, 4, 63, 199, 10, 61, 112, 163, 215, 10>>
  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
