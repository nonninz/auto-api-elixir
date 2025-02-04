# AutoAPI
# The MIT License
#
# Copyright (c) 2018- High-Mobility GmbH (https://high-mobility.com)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
defmodule AutoApi.HonkHornFlashLightsState do
  @moduledoc """
  Keeps HonkHornFlashLights state
  """

  alias AutoApi.{CommonData, State, UnitType}

  @type flashers ::
          :inactive | :emergency_flasher_active | :left_flasher_active | :right_flasher_active

  use AutoApi.State, spec_file: "honk_horn_flash_lights.json"

  @type t :: %__MODULE__{
          flashers: State.property(flashers),
          # Deprecated
          honk_seconds: State.property(UnitType.duration()),
          flash_times: State.property(non_neg_integer()),
          emergency_flashers_state: State.property(CommonData.activity()),
          honk_time: State.property(UnitType.duration())
        }

  @doc """
  Build state based on binary value

    iex> bin = <<1, 0, 4, 1, 0, 1, 0>>
    iex> AutoApi.HonkHornFlashLightsState.from_bin(bin)
    %AutoApi.HonkHornFlashLightsState{flashers: %AutoApi.PropertyComponent{data: :inactive}}
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @spec to_bin(__MODULE__.t()) :: binary
  @doc """
  Parse state to bin

    iex> state = %AutoApi.HonkHornFlashLightsState{flashers: %AutoApi.PropertyComponent{data: :inactive}}
    iex> AutoApi.HonkHornFlashLightsState.to_bin(state)
    <<1, 0, 4, 1, 0, 1, 0>>
  """
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
