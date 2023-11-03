class Survey < ApplicationRecord
  #Associations
  belongs_to :participant

  #Validations
  validates :participant_id, uniqueness: true
end
