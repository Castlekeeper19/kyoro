require 'rails_helper'

RSpec.describe Survey, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      survey = Survey.new(content: 'sample context', options: 'sample options')
      expect(survey.valid?).to eq(false)
    end
  end

  context '#response_number' do
    let(:survey) { Survey.new(user: User.last, name: 'spec survey') }

    it 'should return the number of unique UserAnswers (by User through user_answers)' do
      survey.user_answers = [UserAnswer.new(user: User.last), UserAnswer.new(user: User.first)]
      expect(survey.response_number).to eq(2)
    end
  end
end
