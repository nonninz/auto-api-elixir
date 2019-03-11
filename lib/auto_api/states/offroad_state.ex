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
defmodule AutoApi.OffroadState do
  @moduledoc """
  Offroad state
  """

  alias AutoApi.{CommonData, PropertyComponent}

  defstruct route_incline: nil,
            wheel_suspension: nil,
            timestamp: nil,
            properties: [],
            property_timestamps: %{}

  use AutoApi.State, spec_file: "specs/offroad.json"

  @type t :: %__MODULE__{
          route_incline: %PropertyComponent{data: integer} | nil,
          wheel_suspension: %PropertyComponent{data: float} | nil,
          timestamp: DateTime.t() | nil,
          properties: list(atom),
          property_timestamps: map()
        }

  @doc """
  Build state based on binary value

    iex> bin = <<1, 0, 5, 1, 0, 2, 0, 22>>
    iex> AutoApi.OffroadState.from_bin(bin)
    %AutoApi.OffroadState{route_incline: %AutoApi.PropertyComponent{data: 22}}
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @doc """
  Parse state to bin

    iex> state = %AutoApi.OffroadState{route_incline: %AutoApi.PropertyComponent{data: 22}, properties: [:route_incline]}
    iex> AutoApi.OffroadState.to_bin(state)
    <<1, 0, 5, 1, 0, 2, 0, 22>>
  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
