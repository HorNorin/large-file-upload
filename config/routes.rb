Rails.application.routes.draw do
  resources :uploads
  post '/chunk_upload' => 'uploads#chunk_create'
end
