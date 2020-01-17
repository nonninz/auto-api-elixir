defmodule AutoApi.CapabilitiesState do
  @moduledoc """
  Capabilities state

  This is a minimal implementation that has low-level capability and
  property binary IDs in the struct as well. A future implementation
  will translate those into modules and property names.
  """

  alias AutoApi.PropertyComponent

  defstruct capabilities: [],
            timestamp: nil

  use AutoApi.State, spec_file: "specs/capabilities.json"

  @type capability :: %PropertyComponent{
          data: %{
            capability_id: integer(),
            supported_property_ids: binary()
          }
        }

  @type t :: %__MODULE__{
          capabilities: list(capability()),
          timestamp: DateTime.t() | nil
        }

  @doc """
  Build state based on binary value

  ## Examples

      iex> bin = <<1, 0, 9, 1, 0, 6, 0, 51, 0, 2, 4, 13>>
      iex> AutoApi.CapabilitiesState.from_bin(bin)
      %AutoApi.CapabilitiesState{capabilities: [%AutoApi.PropertyComponent{data: %{capability_id: 0x33, supported_property_ids: <<0x04, 0x0D>>}}]}

  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(binary) do
    parse_bin_properties(binary, %__MODULE__{})
  end

  @doc """
  Parse state to bin

  ## Examples

      iex> state = %AutoApi.CapabilitiesState{capabilities: [%AutoApi.PropertyComponent{data: %{capability_id: 0x33, supported_property_ids: <<0x04, 0x0D>>}}]}
      iex> AutoApi.CapabilitiesState.to_bin(state)
      <<1, 0, 9, 1, 0, 6, 0, 51, 0, 2, 4, 13>>

  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
