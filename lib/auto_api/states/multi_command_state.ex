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
defmodule AutoApi.MultiCommandState do
  @moduledoc """
  MultiCommand state
  """

  alias AutoApi.State

  use AutoApi.State, spec_file: "multi_command.json"

  @type t :: %__MODULE__{
          multi_states: State.multiple_property(struct()),
          multi_commands: State.multiple_property(struct())
        }

  @doc """
  Build state based on binary value

    iex> AutoApi.MultiCommandState.from_bin(<<1, 0, 14, 1, 0, 11, 12, 0, 103, 1, 1, 0, 4, 1, 0, 1, 0>>)
    %AutoApi.MultiCommandState{multi_states: [%AutoApi.PropertyComponent{data: %AutoApi.HoodState{position: %AutoApi.PropertyComponent{data: :closed}}}]}
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @doc """
  Parse state to bin

    iex> state = %AutoApi.PropertyComponent{data: %AutoApi.HoodState{position: %AutoApi.PropertyComponent{data: :closed}}}
    iex> AutoApi.MultiCommandState.to_bin(%AutoApi.MultiCommandState{multi_states: [state]})
    <<1, 0, 14, 1, 0, 11, 12, 0, 103, 1, 1, 0, 4, 1, 0, 1, 0>>
  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
