class SurveysController < ApplicationController
  before_action :set_survey, only: [:show]

  def index
    @surveys = policy_scope(Survey)
    @surveys = Survey.all

    # @progress =
  end

  def show
  end

  def new
    @survey = Survey.new
    @survey.questions.build.answers.build
    # @survey.answers.build

    authorize @survey
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.user = current_user
    authorize @survey

    if @survey.save
      redirect_to survey_path(@survey)
    else
      render 'new.html.erb'
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
    authorize @survey
  end

  def survey_params
    params.require(:survey).permit(:name, :content, questions_attributes: [:content, answers_attributes: [:content, :category]])
  end
end
