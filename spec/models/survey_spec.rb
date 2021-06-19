require 'rails_helper'

RSpec.describe Survey, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      survey = Survey.new(content: 'sample context', options: 'sample options')
      expect(survey.valid?).to eq(false)
    end
  end

  context 'scope tests' do

  end
end
