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
defmodule AutoApi.StateTest do
  use ExUnit.Case
  alias AutoApi.{PropertyComponent, DiagnosticsState, VehicleLocationState}

  describe "symmetric from_bin/1 & to_bin/1" do
    test "integer size 4" do
      state = %DiagnosticsState{mileage: %PropertyComponent{data: 16_777_215}}

      new_state =
        state
        |> DiagnosticsState.to_bin()
        |> DiagnosticsState.from_bin()

      assert new_state.mileage.data == 16_777_215
    end

    test "integer size 2" do
      state = %DiagnosticsState{speed: %PropertyComponent{data: 65535}}

      new_state =
        state
        |> DiagnosticsState.to_bin()
        |> DiagnosticsState.from_bin()

      assert new_state.speed.data == 65535
    end

    test "double size 8" do
      state = %DiagnosticsState{fuel_level: %PropertyComponent{data: 1.1002}}

      new_state =
        state
        |> DiagnosticsState.to_bin()
        |> DiagnosticsState.from_bin()

      assert new_state.fuel_level.data == 1.1002
    end

    test "float size 4" do
      state = %DiagnosticsState{engine_total_fuel_consumption: %PropertyComponent{data: 1.1003}}

      new_state =
        state
        |> DiagnosticsState.to_bin()
        |> DiagnosticsState.from_bin()

      assert new_state.engine_total_fuel_consumption.data == 1.1003
    end

    test "enum" do
      state = %DiagnosticsState{brake_fluid_level: %PropertyComponent{data: :low}}

      new_state =
        state
        |> DiagnosticsState.to_bin()
        |> DiagnosticsState.from_bin()

      assert new_state.brake_fluid_level.data == :low
    end

    test "map" do
      coordinates = %PropertyComponent{data: %{latitude: 52.442292, longitude: 13.176732}}
      state = %VehicleLocationState{coordinates: coordinates}

      new_state =
        state
        |> VehicleLocationState.to_bin()
        |> VehicleLocationState.from_bin()

      assert new_state.coordinates == coordinates
    end

    test "list of map" do
      tire_pressures = %PropertyComponent{data: %{location: :front_left, pressure: 22.034}}

      state =
        %DiagnosticsState{tire_pressures: [tire_pressures]}
        |> DiagnosticsState.to_bin()
        |> DiagnosticsState.from_bin()

      assert state.tire_pressures == [tire_pressures]
    end

    test "failure" do
      coordinates = %PropertyComponent{failure: %{reason: :unknown, description: "Unknown"}}
      state = %VehicleLocationState{coordinates: coordinates}

      new_state =
        state
        |> VehicleLocationState.to_bin()
        |> VehicleLocationState.from_bin()

      assert new_state.coordinates == coordinates
    end
  end
end
