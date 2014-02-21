Rails.application.routes.draw do

  mount Notify::Engine => "/notify"
end
