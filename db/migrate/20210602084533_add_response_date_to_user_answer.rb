class AddResponseDateToUserAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :user_answers, :response_date, :date
  end
end
