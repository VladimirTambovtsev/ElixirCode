defmodule Servy.Parser do

	alias Servy.Conv

	@doc "Split request to method, path and protocol"
	def parse(request) do
		[top, params_string] = String.split(request, "\n\n")

		[method, path, _] =		# _ = request.protocol
			request 
			|> String.split("\n") 
			|> List.first
			|> String.split(" ")
		
		%Conv{ method: method, path: path }
	end
end