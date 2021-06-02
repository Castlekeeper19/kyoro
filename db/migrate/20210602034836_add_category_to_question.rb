class AddCategoryToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :category, :string
  end
end
