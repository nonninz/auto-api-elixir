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
defmodule AutoApi.DiagnosticsState do
  @moduledoc """
  Keeps Diagnostics state

  engine_oil_temperature: Engine oil temperature in Celsius, whereas can be negative
  """

  alias AutoApi.{CommonData, PropertyComponent}

  @type fluid_level :: :low | :filled
  @type position :: :front_left | :front_right | :rear_right | :rear_left
  @type tire_data :: %{position: position, pressure: float}
  @doc """
  Diagnostics state
  """
  defstruct mileage: nil,
            engine_oil_temperature: nil,
            speed: nil,
            engine_rpm: nil,
            fuel_level: nil,
            estimated_range: nil,
            washer_fluid_level: nil,
            battery_voltage: nil,
            adblue_level: nil,
            distance_since_reset: nil,
            distance_since_start: nil,
            fuel_volume: nil,
            anti_lock_braking: nil,
            engine_coolant_temperature: nil,
            engine_total_operating_hours: nil,
            engine_total_fuel_consumption: nil,
            brake_fluid_level: nil,
            engine_torque: nil,
            engine_load: nil,
            wheel_based_speed: nil,
            battery_level: nil,
            check_control_messages: [],
            tire_temperatures: [],
            tire_pressures: [],
            wheel_rpms: [],
            trouble_codes: [],
            mileage_meters: nil,
            timestamp: nil,
            properties: [],
            property_timestamps: %{}

  use AutoApi.State, spec_file: "specs/diagnostics.json"

  @type check_control_message :: %PropertyComponent{
          data: %{
            id: integer,
            remaining_minutes: integer,
            text_size: integer,
            text: String.t(),
            status_size: integer,
            status: String.t()
          }
        }

  @type tire_temperature :: %PropertyComponent{
          data: %{
            location: CommonData.location(),
            temperature: float
          }
        }

  @type tire_pressure :: %PropertyComponent{
          data: %{
            location: CommonData.location(),
            pressure: float
          }
        }

  @type wheel_rpm :: %PropertyComponent{
          data: %{
            location: CommonData.location(),
            rpm: integer
          }
        }

  @type trouble_code :: %PropertyComponent{
          data: %{
            occurences: integer,
            id_size: integer,
            id: String.t(),
            ecu_id_size: integer,
            ecu_id: String.t(),
            status_size: integer,
            status: String.t()
          }
        }

  @type t :: %__MODULE__{
          mileage: %PropertyComponent{data: integer} | nil,
          engine_oil_temperature: %PropertyComponent{data: integer} | nil,
          speed: %PropertyComponent{data: integer} | nil,
          engine_rpm: %PropertyComponent{data: integer} | nil,
          fuel_level: %PropertyComponent{data: float} | nil,
          estimated_range: %PropertyComponent{data: integer} | nil,
          washer_fluid_level: %PropertyComponent{data: fluid_level} | nil,
          battery_voltage: %PropertyComponent{data: float} | nil,
          adblue_level: %PropertyComponent{data: float} | nil,
          distance_since_reset: %PropertyComponent{data: integer} | nil,
          distance_since_start: %PropertyComponent{data: integer} | nil,
          fuel_volume: %PropertyComponent{data: float} | nil,
          anti_lock_braking: %PropertyComponent{data: CommonData.activity()} | nil,
          engine_coolant_temperature: %PropertyComponent{data: integer} | nil,
          engine_total_operating_hours: %PropertyComponent{data: float} | nil,
          engine_total_fuel_consumption: %PropertyComponent{data: float} | nil,
          brake_fluid_level: %PropertyComponent{data: fluid_level} | nil,
          engine_torque: %PropertyComponent{data: float} | nil,
          engine_load: %PropertyComponent{data: float} | nil,
          wheel_based_speed: %PropertyComponent{data: integer} | nil,
          battery_level: %PropertyComponent{data: float} | nil,
          check_control_messages: list(check_control_message),
          tire_pressures: list(tire_pressure),
          tire_temperatures: list(tire_temperature),
          wheel_rpms: list(wheel_rpm),
          trouble_codes: list(trouble_code),
          mileage_meters: %PropertyComponent{data: integer} | nil,
          timestamp: DateTime.t() | nil,
          properties: list(atom),
          property_timestamps: map()
        }

  @doc """
  Build state based on binary value

    iex> bin = <<1, 0, 7, 1, 0, 4, 0, 0, 0, 12>>
    iex> AutoApi.DiagnosticsState.from_bin(bin)
    %AutoApi.DiagnosticsState{mileage: %AutoApi.PropertyComponent{data: 12}}
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @spec to_bin(__MODULE__.t()) :: binary
  @doc """
  Parse state to bin

    iex> state = %AutoApi.DiagnosticsState{mileage: %AutoApi.PropertyComponent{data: 12}, properties: [:mileage]}
    iex> AutoApi.DiagnosticsState.to_bin(state)
    <<1, 0, 7, 1, 0, 4, 0, 0, 0, 12>>
  """
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
