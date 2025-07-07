class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :status
      t.string :category
      t.text :memo
      t.integer :user_id

      t.timestamps
    end
  end
end
