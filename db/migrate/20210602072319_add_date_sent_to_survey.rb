  class AddDateSentToSurvey < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :date_sent, :date
  end
end
