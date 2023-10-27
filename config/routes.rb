Rails.application.routes.draw do
  get 'weathers/index'
  root 'weathers#index'
end
