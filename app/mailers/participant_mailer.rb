class ParticipantMailer < ActionMailer::Base
    def subscription_confirmation_email(participant)
        @participant = participant
        mail(from: 'challengemicolet@gmail.com', to: @participant.email, subject: 'Welcome to Micolet Newsletter')
    end
end