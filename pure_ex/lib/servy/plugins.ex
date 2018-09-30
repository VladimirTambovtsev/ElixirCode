defmodule Servy.Plugins do
	@doc "Log request"
	def log(conv), do: IO.inspect conv

	def rewrite_path(%{ path: "/wildthings" } = conv) do
		%{ conv | path: "/wildthings" }
	end

	def rewrite_path(conv), do: conv

	@doc "Track not found file for current file"
	def track(%{status: 404, path: path} = conv) do
		IO.puts "Warning, #{path} is on the loose"
		conv
	end

	def track(conv), do: conv
end
