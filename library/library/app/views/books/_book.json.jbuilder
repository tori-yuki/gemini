json.extract! book, :id, :title, :author, :status, :category, :memo, :user_id, :created_at, :updated_at
json.url book_url(book, format: :json)
