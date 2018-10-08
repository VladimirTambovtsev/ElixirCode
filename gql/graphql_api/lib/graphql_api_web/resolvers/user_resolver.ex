defmodule GraphqlApiWeb.Resolvers.UserResolver do
	alias GraphqlApi.Accounts

	def users(_, _, _) do
		{:ok, Accounts.list_users()}
	end
end