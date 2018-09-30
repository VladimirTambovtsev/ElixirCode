defmodule Servy.Handler do
	@pages_path Path.expand("../../pages", __DIR__)		# creates constanst

	import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
	import Servy.Parser
	@moduledoc "Handles HTTP request"

	@doc "Transform the request into response"
	def handle(request) do
		request 
		|> parse 
		|> rewrite_path
		|> log
		|> route 
		|> track
		|> format_response
	end



	# def route(conv) do
	# 	route(conv, conv.method, conv.path)
	# end

	@doc "Respond on /wildthings path"
	def route(%{ method: "GET", path: "/wildthings" } = conv) do
		%{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
	end

	def route(%{ method: "GET", path: "/bears" } = conv) do
		%{ conv | status: 200, resp_body: "Bears list" }
	end

	def route(%{ method: "GET", path: "/bears" <> id } = conv) do
		%{conv | status: 200, resp_body: "Bear #{id}"}
	end

	@doc "Serve static file as a response"
	def route(%{method: "GET", path: "/about"} = conv) do
	  @pages_path
	  |> Path.join("about.html")
	  |> File.read
	  |> handle_file(conv)
	end

	def handle_file({:ok, content}, conv) do
	%{ conv | status: 200, resp_body: content }
	end

	def handle_file({:error, :enoent}, conv) do
	%{ conv | status: 404, resp_body: "File not found ¯\_(ツ)_/¯" }
	end

	def handle_file({:error, reason}, conv) do
	%{ conv | status: 500, resp_body: "File error: #{reason}" }
	end

	# def route(%{method: "GET", path: "/about"} = conv) do
	#   file = 
	#     Path.expand("../../pages", __DIR__)
	#     |> Path.join("about.html")

	#   case File.read(file) do
	#     {:ok, content} ->
	#       %{ conv | status: 200, resp_body: content }

	#     {:error, :enoent} ->
	#       %{ conv | status: 404, resp_body: "File not found!" }

	#     {:error, reason} ->
	#       %{ conv | status: 500, resp_body: "File error: #{reason}" }
	#   end
	# end

	def route(%{ path: path } = conv) do
		%{ conv | status: 404, resp_body: "No #{path} here" }
	end

	@doc "Show current response"
	def format_response(conv) do
		"""
		HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
		Content-Type: text/html
		Content-Length: #{String.length(conv.resp_body)}

		#{conv.resp_body}
		"""
	end

	defp status_reason(code) do
		%{
			200 => "OK",
			201 => "Created",
			401 => "Unauthorized",
			403 => "Forbidden",
			404 => "Not Found",
			500 => "Internal Server Error"
		}[code]
	end
end

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)