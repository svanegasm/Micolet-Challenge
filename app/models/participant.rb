class Participant < ApplicationRecord
    #Associations
    has_one :survey, dependent: :destroy

    #Callbacks
    before_create :preferences_present?
    before_create :validate_email_abstract_service

    #Validations
    validates :email, presence: true
    validates :email, uniqueness: { case_sensitive: false }

    def preferences_present?
        if !women_fashion_preference && !men_fashion_preference && !children_fashion_preference
            errors.add(:base, "You must select at least one preference")
            throw(:abort)
        end
    end

    def validate_email_abstract_service
        response = AbstractService.validate_email(email)

        if response['quality_score'].try(:to_f) < 0.7
            errors.add(:base, "Your Email address is invalid. Please try again.")
            throw(:abort)
        end
    end
end
