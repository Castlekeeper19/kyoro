class AddNatureToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nature, :string, array: true, default: []
  end
end
