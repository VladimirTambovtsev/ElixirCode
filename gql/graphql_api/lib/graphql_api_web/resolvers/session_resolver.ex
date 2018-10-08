defmodule GraphqlApiWeb.Resolvers.SessionResolver do
	
	alias GraphqlApi.{Accounts, Guardian}

	def login_user(_,%{input: input},_) do
		# check if the user is in db 
		with {:ok, user}  <- Accounts.Session.authenticate(input),
			 {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
			{:ok, %{token: jwt_token, user: user}}
		end
	end
end

