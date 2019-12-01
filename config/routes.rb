require 'resque/server'
require 'resque/scheduler'
require 'resque/scheduler/server'

Rails.application.routes.draw do
  resources :instruments

  mount Resque::Server.new, at: "/resque"
end
