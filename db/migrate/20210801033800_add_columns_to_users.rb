# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image_name, :string
    add_column :users, :password, :string
  end
end
