Notify::Engine.routes.draw do
  get "/all/read" => "notifications#read_all", as: "read_all"
  get "/:id/read" => "notifications#read", as: "read"
  get "/" => "notifications#index", as: "index"
  get "/:id" => "notifications#show", as: "show"
end
