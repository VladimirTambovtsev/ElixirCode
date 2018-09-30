defmodule Servy.Handler do
	@moduledoc "Handles HTTP request"
	@pages_path Path.expand("../../pages", __DIR__)		# creates constanst

	import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
	import Servy.Parser

	alias Servy.Conv

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



	@doc "Respond on /wildthings path"
	def route(%Conv{ method: "GET", path: "/wildthings" } = conv) do
		%{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
	end

	def route(%Conv{ method: "GET", path: "/bears" } = conv) do
		params = %{ "name" => "Baloo", "type" => "Brown" }
		%{ conv | status: 200, resp_body: "Bears list \n params: #{params["name"]}" }
	end

	def route(%Conv{ method: "GET", path: "/bears" <> id } = conv) do
		%{conv | status: 200, resp_body: "Bear #{id}"}
	end

	@doc "Serve static file as a response"
	def route(%Conv{method: "GET", path: "/about"} = conv) do
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



	def route(%{ path: path } = conv) do
		%{ conv | status: 404, resp_body: "No #{path} here" }
	end

	@doc "Show current response"
	def format_response(%Conv{} = conv) do
		"""
		HTTP/1.1 #{Conv.full_status(conv)}
		Content-Type: text/html
		Content-Length: #{String.length(conv.resp_body)}

		#{conv.resp_body}
		"""
	end

end

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 12

name=Baloo&type=Brown
"""

response = Servy.Handler.handle(request)

IO.puts(response)

