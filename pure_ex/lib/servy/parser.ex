defmodule Servy.Parser do
	@doc "Split request to method, path and protocol"
	def parse(request) do
		[method, path, _] =		# _ = request.protocol
			request 
			|> String.split("\n") 
			|> List.first
			|> String.split(" ")
		
		%{ method: method, path: path, resp_body: "", status: nil }
	end
end