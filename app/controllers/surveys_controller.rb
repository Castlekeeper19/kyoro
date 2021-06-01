class SurveysController < ApplicationController
  before_action :set_survey, only: [:show]

  def index
    @surveys = policy_scope(Survey)
    @surveys = Survey.all
  end

  def show
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)

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
    params.require(:survey).permit(:name, :content)
  end
end
