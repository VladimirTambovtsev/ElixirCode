defmodule GraphqlApi.Accounts.Session do
	
	alias GraphqlApi.Accounts.User
	alias GraphqlApi.Repo

	def authenticate(args) do
		user = Repo.get_by(User, email: String.downcase(args.email))

		case check_password(user, args) do
			true -> {:ok, user}
			_ -> {:error, "Invalid login or password credentials"}
		end
	end

	defp check_password(user, args) do
		case user do
			nil -> Comeonin.Argon2.dummy_checkpw()
			_ -> Comeonin.Argon2.checkpw(args.password, user.password_hash)
		end
	end
end