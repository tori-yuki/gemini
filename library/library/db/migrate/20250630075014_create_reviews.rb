class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
  end
end
