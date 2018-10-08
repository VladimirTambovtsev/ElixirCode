defmodule GraphqlApiWeb.Router do
  use GraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward("/graphql", Absinthe.Plug, schema: GraphqlApiWeb.Schema)

    if Mix.env() == :dev do
    	forward("/graphiql", Absinthe.Plug.GraphiQL, schema: GraphqlApiWeb.Schema)
    end
  end
end
