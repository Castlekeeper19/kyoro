class AddOptionsToSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :options, :string
  end
end
