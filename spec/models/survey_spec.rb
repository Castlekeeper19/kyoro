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
      # implement survey's question
      # implement question's answer
      # assign UserAnswers below to question
      survey.user_answers = [UserAnswer.new(user: User.last), UserAnswer.new(user: User.first)]
      expect(survey.response_number).to eq(2)
    end
  end

  #   context '#response_rate' do
  #     it 'should return the percentage of respondents as the numerator only' do
  #       expect().to eq(50)
  #     end
  #   end

  #   context '#response_color' do
  #     it 'should return #73BF8F when rate is greater than 80' do
  #       response = 85
  #       expect().to eq('#73BF8F')
  #     end
  #     it 'should return #FFE270 when rate is between 70 and 80' do
  #       expect().to eq('#FFE270')
  #     end
  #   end
end
