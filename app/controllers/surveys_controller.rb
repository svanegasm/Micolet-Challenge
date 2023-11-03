class SurveysController < ApplicationController
    def new
      @step = (params[:step] || 1).to_i
      @participant_id = params[:participant_id]
      @survey = Survey.new(session[:survey_data])
    end
    
    def create
      save_data_to_session

      case params[:commit]
      when t("next_button")
        redirect_to new_survey_path(step: @step + 1, participant_id: @participant_id)
      when t("previous_button")
        redirect_to new_survey_path(step: @step - 1, participant_id: @participant_id)
      when t("submit_button")
        save_survey
      end
    end

    def render_survey_completion
      render 'static_pages/survey_completion.html.erb'
    end
    
    private
    def save_data_to_session
      session[:survey_data] ||= {}
      session[:survey_data].merge!(survey_params.to_h)
      @step = params[:step].to_i
      @participant_id = params[:participant_id]
    end
    
    def save_survey
      @participant = Participant.find_by(id: params[:participant_id])
      unless @participant
        redirect_to new_participant_path
        flash[:notice] = "Something went wrong. Please, try again."
        return
      end

      @survey = Survey.new(session[:survey_data])
      @survey.participant = @participant
      if @survey.save
        session.delete(:survey_data)
        redirect_to render_survey_completion_surveys_path
      else
        redirect_to new_participant_path
        flash[:notice] = "Something went wrong. Please, try again."
      end
    end
    
    def survey_params
      params.require(:survey).permit(:question1, :question2, :question3, :question4)
    end
end
