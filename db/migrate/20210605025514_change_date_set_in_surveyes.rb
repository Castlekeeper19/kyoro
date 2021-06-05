class ChangeDateSetInSurveyes < ActiveRecord::Migration[6.0]
  def change
    change_column :surveys, :date_sent, :date, :default => Date.today
  end
end
