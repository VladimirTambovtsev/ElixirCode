defmodule GraphqlApiWeb.Schema.Types do
	use Absinthe.Schema.Notation

	alias GraphqlApiWeb.Schema.Types

	import_types(Types.Usertype)

end