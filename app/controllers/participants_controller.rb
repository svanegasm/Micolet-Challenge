class ParticipantsController < ApplicationController
    def new
        @participant = Participant.new
    end

    def create
        @participant = Participant.new(participant_params)

        if @participant.save
            ParticipantMailer.subscription_confirmation_email(@participant).deliver_now
            redirect_to ask_for_survey_participants_path(id: @participant.id)
        else
            render :new
        end
    end

    def ask_for_survey
        @participant = Participant.find(params[:id])
    end

    def survey_decision
        @participant = Participant.find(params[:id])

        if params[:answer] == 'yes'
            redirect_to new_survey_path(participant_id: @participant.id)
        else
            render 'static_pages/no_survey.html.erb'
        end
    end

    

    private
    def participant_params
        params.require(:participant).permit(
            :email,
            :women_fashion_preference,
            :men_fashion_preference,
            :children_fashion_preference
        )
    end
end
