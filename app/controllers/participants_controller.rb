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
            redirect_to new_participant_path
            flash[:notice] = "Something went wrong. Please, try again."
        end
    end

    def ask_for_survey
        @participant_id = params[:id]
    end

    def survey_decision
        @participant = Participant.find_by(id: params[:id])

        if @participant
            if params[:answer] == 'yes'
                redirect_to new_survey_path(participant_id: @participant.id)
            else
                render 'static_pages/no_survey.html.erb'
            end
        else
            redirect_to new_participant_path
            flash[:notice] = "Participant not found. Please, try again."
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
