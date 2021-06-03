class AddAnswerScoreToUserAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :user_answers, :answer_score, :integer
  end
end
