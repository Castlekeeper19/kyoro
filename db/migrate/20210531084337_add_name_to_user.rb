class AddNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :company, :string
    add_column :users, :slack_username, :string
    add_column :users, :title, :string
    add_column :users, :role, :string
    add_column :users, :goal, :text
  end
end
