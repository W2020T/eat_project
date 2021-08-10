# frozen_string_literal: true

class AddPassawordToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password, :string
  end
end
