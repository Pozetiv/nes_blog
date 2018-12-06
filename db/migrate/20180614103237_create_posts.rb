class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title, index: true
      t.text :content

      t.timestamps
    end

    add_foreign_key :posts, :users, column: :user_id
  end
end
