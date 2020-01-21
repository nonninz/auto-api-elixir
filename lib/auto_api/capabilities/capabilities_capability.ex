defmodule AutoApi.CapabilitiesCapability do
  @moduledoc """
  Basic settings for Capabilities "Capability".

      iex> alias AutoApi.CapabilitiesCapability, as: C
      iex> C.identifier
      <<0x00, 0x10>>
      iex> C.name
      :capabilities
      iex> C.description
      "Capabilities"
      iex> List.last(C.properties)
      {0x01, :capabilities}
  """

  @command_module AutoApi.CapabilitiesCommand
  @state_module AutoApi.CapabilitiesState

  use AutoApi.Capability, spec_file: "specs/capabilities.json"
end
