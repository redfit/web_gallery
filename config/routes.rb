WebGallery::Application.routes.draw do
  resources :bookmarks do
    resources 'colors', only: [:index, :create, :destroy]
  end
  root to: "bookmarks#index"
end
