Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'electronic_polices/list'

  get 'welcome/dashboard'

  resources :changces, :guandians, :pingces
  resources :editors do
    get :actives, on: :collection
    post :status, on: :member
  end

  get 'daogous/search' => 'daogous#search'

  resources :daogoulists, :daogous
  get 'changces/author/:id' => 'changces#author'
  get 'guandians/author/:id' => 'guandians#author'
  get 'pingces/author/:id' => 'pingces#author'
  get 'daogous/author/:id' => 'daogous#author', as: :daogous_author
  get 'daogous/daogoulist/:id' => 'daogous#daogoulist', as: :dgdglist

  root 'electronic_polices#list'

end
