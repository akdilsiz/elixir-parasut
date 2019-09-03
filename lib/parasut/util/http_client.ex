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
defmodule Parasut.Util.HttpClient do
	@moduledoc false
	
	def request(conf, method, url, headers, body, opts \\ []) 
		when is_atom(method) and is_binary(url) do
		url = String.to_charlist(url)
		httpc_opts = conf[:httpc_opts] || []

		case method do
			:get ->
				headers = headers ++ opts
				:httpc.request(:get, {url, headers}, httpc_opts, body_format: :binary)
			_ ->
				headers = headers ++ [{'Content-Type', 'application/json'}]
				:httpc.request(method, 
					{url, headers, 'application/json', Jason.encode!(body)}, 
					httpc_opts, body_format: :binary)
		end
		|> normalize_response
	end

	@spec gen_query_string(Any.t) :: String.t 
	def gen_query_string(model) do
		URI.encode_query(Map.from_struct(model))
	end

	defp normalize_response(response) do
		case response do
			{:ok, {{_httpvs, 200, _status_phrase}, json_body}} ->
				{:ok, Jason.decode!(json_body)}
			{:ok, {{_httpvs, 200, _status_phrase}, _headers, json_body}} ->
				{:ok, Jason.decode!(json_body)}
			{:ok, {{_httpvs, status, _status_phrase}, json_body}} ->
				{:error, status, Jason.decode!(json_body)}
			{:ok, {{_httpvs, status, _status_phrase}, _headers, json_body}} ->
				{:error, status, Jason.decode!(json_body)}
			{:error, reason} -> {:error, :bad_fetch, reason}
		end
	end
end