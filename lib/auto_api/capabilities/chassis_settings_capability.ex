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
defmodule AutoApi.ChassisSettingsCapability do
  @moduledoc """
  Basic settings for Chassis Settings Capability

      iex> alias AutoApi.ChassisSettingsCapability, as: C
      iex> C.identifier
      <<0x00, 0x53>>
      iex> C.name
      :chassis_settings
      iex> C.description
      "Chassis Settings"
      iex> length(C.properties)
      13
      iex> List.first(C.properties)
      {0x01, :driving_mode}
  """

  @command_module AutoApi.ChassisSettingsCommand
  @state_module AutoApi.ChassisSettingsState

  use AutoApi.Capability, spec_file: "chassis_settings.json"
end
