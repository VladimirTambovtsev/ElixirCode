defmodule Servy.Plugins do

	alias Servy.Conv

	@doc "Log request"
	def log(%Conv{} = conv), do: IO.inspect conv

	def rewrite_path(%Conv{ path: "/wildthings" } = conv) do
		%{ conv | path: "/wildthings" }
	end

	def rewrite_path(%Conv{} = conv), do: conv

	@doc "Track not found file for current file"
	def track(%Conv{status: 404, path: path} = conv) do
		IO.puts "Warning, #{path} is on the loose"
		conv
	end

	def track(%Conv{} = conv), do: conv
end
