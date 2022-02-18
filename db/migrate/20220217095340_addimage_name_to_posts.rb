class AddimageNameToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :image_name, :string
  end
end
