defmodule Chat.Supervisor do
	use Supervisor
	@moduledoc """
  	If one of the processes dies, supervisor tries to spin it up
  	"""

	def start_link do
		Supervisor.start_link(__MODULE__, [])
	end

	def init(_) do
		children = [
			worker(Chat.Server, [])
		]

		supervise(children, strategy: :one_for_one)	# reset process
	end
end