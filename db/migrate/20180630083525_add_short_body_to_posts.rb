class AddShortBodyToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :short_body, :string
  end
end
