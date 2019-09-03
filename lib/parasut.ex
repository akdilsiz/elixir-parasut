#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule Parasut do
  @moduledoc false

  defmacro static_assert_binary(param) do
    quote do
      unless is_binary(unquote(param)) do
        raise Parasut.InvalidConfigurationError
      end
    end
  end

  defmacro static_assert_map(param) do
    quote do
      unless is_map(unquote(param)) do
        raise Parasut.InvalidConfigurationError
      end
    end
  end

  defmacro static_assert_tuple(param) do
    quote do
      unless is_tuple(unquote(param)) do
        raise Parasut.InvalidConfigurationError
      end
    end
  end

  def start do
    :ok
  end
end
