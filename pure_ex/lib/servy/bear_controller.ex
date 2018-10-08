defmodule Servy.BearController do
  
  alias Servy.Wildthings
  alias Servy.Bear

  @template_path Path.expand("../../templates", __DIR__)

  def index(conv) do
    bears = 
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)
      |> Enum.join

    content = 
      @template_path
      |> Path.join("index.eex")
      |> EEx.eval_file(bears: bears)

    %{ conv | status: 200, resp_body: content }    
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    %{ conv | status: 200, resp_body: "<h1>Bear #{bear.id}: #{bear.name}</h1>" }
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{ conv | status: 201, 
              resp_body: "Created a #{type} bear named #{name}!" }
  end

end
