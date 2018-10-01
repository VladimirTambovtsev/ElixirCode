defmodule PlugEx.Router do
	use Plug.Router

	plug :match
	plug :dispatch
	plug Plug.Static, at: "/home", from: :server

	get "/" do
		conn = put_resp_content_type(conn, "text/html")
		send_file(conn, 200, "lib/index.html")
	end

	get "/about/:user_name" do
		send_resp(conn, 200, "Hello, #{user_name}")
	end

	get "/home" do
		send_resp(conn, 200, "Hello there")
	end

	match _, do: send_resp(conn, 404, "404 Error - Not Found")
end