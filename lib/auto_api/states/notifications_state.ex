defmodule AutoApi.NotificationsState do
  @moduledoc """
  Notifications state
  """

  alias AutoApi.PropertyComponent

  defstruct text: nil,
            action_items: [],
            activated_action: nil,
            clear: nil,
            timestamp: nil

  use AutoApi.State, spec_file: "specs/notifications.json"

  @type action_item :: %PropertyComponent{data: %{id: integer, name: String.t()}}

  @type t :: %__MODULE__{
          text: %PropertyComponent{data: String.t()} | nil,
          action_items: list(action_item),
          activated_action: %PropertyComponent{data: integer} | nil,
          clear: %PropertyComponent{data: :clear} | nil,
          timestamp: DateTime.t() | nil
        }

  @doc """
  Build state based on binary value

    iex> bin = <<1, 0, 20, 1, 0, 17, 110, 111, 116, 105, 102, 105, 99, 97, 116, 105, 111, 110, 32, 116, 101, 120, 116>>
    iex> AutoApi.NotificationsState.from_bin(bin)
    %AutoApi.NotificationsState{text: %AutoApi.PropertyComponent{data: "notification text"}}
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @doc """
  Parse state to bin

    iex> state = %AutoApi.NotificationsState{text: %AutoApi.PropertyComponent{data: "notification text"}}
    iex> AutoApi.NotificationsState.to_bin(state)
    <<1, 0, 20, 1, 0, 17, 110, 111, 116, 105, 102, 105, 99, 97, 116, 105, 111, 110, 32, 116, 101, 120, 116>>
  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
