class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :category_name

      t.timestamps
    end

    add_index :categories, :category_name
    add_column :posts, :category_id, :integer
    add_foreign_key :posts, :categories, column: :category_id
  end
end
