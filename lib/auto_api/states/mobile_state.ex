# AutoAPI
# Copyright (C) 2018 High-Mobility GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see http://www.gnu.org/licenses/.
#
# Please inquire about commercial licensing options at
# licensing@high-mobility.com
defmodule AutoApi.MobileState do
  @moduledoc """
  Browser state
  """

  alias AutoApi.PropertyComponent

  defstruct connection: nil,
            timestamp: nil,
            properties: [],
            property_timestamps: %{}

  use AutoApi.State, spec_file: "specs/mobile.json"

  @type connection :: :disconnected | :connected

  @type t :: %__MODULE__{
          connection: %PropertyComponent{data: connection} | nil,
          timestamp: DateTime.t() | nil,
          properties: list(atom),
          property_timestamps: map()
        }

  @doc """
  Build state based on binary value

    iex> AutoApi.MobileState.from_bin(<<1, 4::integer-16, 1, 0, 1, 1>>)
    %AutoApi.MobileState{connection: %AutoApi.PropertyComponent{data: :connected}}
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @doc """
  Parse state to bin

    iex> state = %AutoApi.MobileState{connection: %AutoApi.PropertyComponent{data: :connected}, properties: [:connection]}
    iex> AutoApi.MobileState.to_bin(state)
    <<1, 4::integer-16, 1, 0, 1, 1>>
  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
